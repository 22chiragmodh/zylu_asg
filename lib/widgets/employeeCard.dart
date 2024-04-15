import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class EmployeeCard extends StatefulWidget {
  final DocumentSnapshot emplyeeDoc;
  final String joinFromatedDate;
  final DateTime datetime;
  EmployeeCard(
      {super.key,
      required this.emplyeeDoc,
      required this.joinFromatedDate,
      required this.datetime});

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  @override
  Widget build(BuildContext context) {
    bool isFlagged = _shouldFlagEmployee(widget.emplyeeDoc, widget.datetime);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: widget.emplyeeDoc['isActive']
                ? Colors.blueAccent.withOpacity(0.4)
                : Colors.redAccent.withOpacity(0.4)),
        height: 100,
        child: Center(
            child: ListTile(
          title: Text("${widget.emplyeeDoc['empName']}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          subtitle: Text("Joining Date: ${widget.joinFromatedDate}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          trailing: Container(
            height: 60,
            width: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Veteran",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                isFlagged
                    ? Icon(
                        Icons.star,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.star_border,
                        color: Colors.green,
                      )
              ],
            ),
          ),
        )),
      ),
    );
  }

  bool _shouldFlagEmployee(DocumentSnapshot emplyeeDoc, DateTime datetime) {
    // Calculate the difference in years
    final today = DateTime.now();
    final difference = today.difference(datetime).inDays;
    final years = difference ~/ 365;

    // Check if the employee has been with the organization for more than 5 years and is active
    return years >= 5 && emplyeeDoc['isActive'];
  }
}
