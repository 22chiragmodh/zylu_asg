import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zylu_asg/widgets/employeeCard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['API_KEY']!,
      appId: dotenv.env['APP_ID']!,
      messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
      projectId: dotenv.env['PROJECT_ID']!,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.montserrat().fontFamily,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _searchController;
  bool isSearching = false;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 50,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        isSearching = value.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Search Employee Name',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabled: true,
                        suffixIcon: const Icon(
                          Feather.search,
                          color: Colors.black,
                          size: 30,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25))),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Employee Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 15,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Employee')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<DocumentSnapshot> employees =
                        snapshot.data?.docs ?? [];

                    // Filtered list based on search
                    List<DocumentSnapshot> filteredEmployees =
                        employees.where((employee) {
                      if (!isSearching) {
                        return true; // Show all employees if not searching
                      }
                      String name =
                          employee['empName'].toString().toLowerCase();
                      String searchTerm = _searchController.text.toLowerCase();
                      return name.contains(searchTerm);
                    }).toList();

                    // when user search for Empoyee but not found
                    if (filteredEmployees.isEmpty && isSearching) {
                      return const Center(
                        child: Text(
                          'No Employee Found',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    }

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredEmployees.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemBuilder: (context, index) {
                          DocumentSnapshot employeeDoc =
                              filteredEmployees[index];
                          Timestamp timestamp =
                              Timestamp.fromMillisecondsSinceEpoch(
                                  employeeDoc['joiningDate']
                                      .millisecondsSinceEpoch);

                          DateTime dateTime = timestamp.toDate();

                          DateFormat newDateFormat =
                              DateFormat("MMMM dd, yyyy");
                          String formattedDate = newDateFormat.format(dateTime);

                          return EmployeeCard(
                            emplyeeDoc: employeeDoc,
                            joinFromatedDate: formattedDate,
                            datetime: dateTime,
                          );
                        });
                  }
                })
          ],
        ),
      ),
    );
  }
}
