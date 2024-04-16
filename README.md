# zylu_asg



### Features
- Firebase Setup: Initialized Firebase in the Flutter app to store and retrieve employee data.
- Employee Details Screen: Implemented a screen to display employee details.
- Search Functionality: Added a search bar to filter employees by name.
- Security with .env: Used a .env file to securely store Firebase API keys.

### Installation

1. Clone the repository:
    ```plaintext
     git clone https://github.com/22chiragmodh/zylu_asg.git
3. Install dependencies:
   ```plaintext
   flutter pub get
4. Create a `.env` file in the root directory of the project:
   ```plaintext
   API_KEY=your_api_key
   APP_ID=your_app_id
   MESSAGING_SENDER_ID=your_messaging_sender_id
   PROJECT_ID=your_project_id
5. Run the app:
   ```plaintext
   flutter run
### Dependencies
- firebase_core: ^2.24.2
- cloud_firestore: ^4.14.0
- intl: ^0.19.0
- google_fonts: 6.1.0
- flutter_vector_icons: ^2.0.0
- flutter_dotenv: ^5.1.0
### Screenshots

##### Employee Details Screen with  Employee Flagging:
- Any employee who has been with the organization for more than 5 years and is active will be flagged with a green-filled star, as shown below:
  <div>
     <img src="https://github.com/22chiragmodh/zylu_asg/assets/91516739/479494df-d4d9-4b22-8a08-b1859951bbce"/>
   
  </div>


##### Search Functionality
- Users can use the search bar to filter employees by name, as demonstrated in the screenshot:
 <div style="display:flex; justify-content:center;">
  <img src="https://github.com/22chiragmodh/zylu_asg/assets/91516739/777b5e7d-1a8b-4a3c-ade4-57d868bdeb20" alt="Flagged Employee" width="400" height="400"/>
  <img src="https://github.com/22chiragmodh/zylu_asg/assets/91516739/187ac1b8-b70c-4a58-8237-0a4949d4e83e" alt="Search Functionality" width="400" height="400"/>
</div>


  
