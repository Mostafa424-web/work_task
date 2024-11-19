// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../home_screen/instructor_screen.dart';
// import '../home_screen/learner_screen.dart';
// import '../home_screen/mentor_screen.dart';
// import 'functions.dart';
// import 'navigator.dart';
//
// class DropDownMenuScreen extends StatefulWidget {
//   const DropDownMenuScreen({super.key, this.userData});
//
//   final Map<String, dynamic>? userData;
//   @override
//   _DropDownMenuScreenState createState() => _DropDownMenuScreenState();
// }
//
// class _DropDownMenuScreenState extends State<DropDownMenuScreen> {
//   // Default selected value
//   String? selectedRole;
//   final List<String> roles = ['Instructor', 'Learner', 'Mentor'];
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     String uid = user!.uid;
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Select Your Role',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             DropdownButtonFormField<String>(
//               value: selectedRole,
//               hint: const Text('Select a role'),
//               items: roles.map((role) {
//                 return DropdownMenuItem<String>(
//                   value: role,
//                   child: Text(role),
//                 );
//               }).toList(),
//               onChanged: (value) async {
//                 setState(() {
//                   selectedRole = value;
//                   FirebaseFirestore.instance.collection('users').doc(uid).update({
//                     'Your Role': value,
//                   });
//                 });
//               },
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (selectedRole == 'Instructor') {
//                   Navigation.navigateToScreen(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const InstructorScreen()));
//                 } else if (selectedRole == 'Learner') {
//                   Navigation.navigateToScreen(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => LearnerScreen(userData: widget.userData,)));
//                 } else if (selectedRole == 'Mentor') {
//                   Navigation.navigateToScreen(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const MentorScreen()));
//                 } else {
//                   showCustomSnackBar(
//                     context: context,
//                     message: "Please select a role before proceeding.",
//                   );
//                 }
//               },
//               child: const Text('Go to Selected Role Screen'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
