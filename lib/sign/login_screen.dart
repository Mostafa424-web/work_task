import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:works/home_screen/instructor_screen.dart';
import '../home_screen/learner_screen.dart';
import '../home_screen/mentor_screen.dart';
import '../utils/functions.dart';
import '../utils/sign_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: emailController,
                validator: (emailController) {
                  if (isValidEmail(emailController!.trim(), context)) {
                    return 'email is valid';
                  } else {
                    return 'email is not valid';
                  }
                },
                decoration: customInputDecoration("enter your email"),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: customInputDecoration("enter your password"),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SignButton(
                text: 'LogIn',
                onPress: () {
                  handleSignIn();
                })
          ],
        ),
      ),
    );
  }
Future<void> handleSignIn() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  try {
    User? user = await signInWithEmailAndPassword(email, password, context);
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic>? userData =
        userDoc.data() as Map<String, dynamic>?;
        String? role = userData?['Your Role'];

        if (role == 'Learner') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LearnerScreen(userData: userData)),
          );
        } else if (role == 'Instructor') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const InstructorScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MentorScreen()),
          );
        }
        // Navigate to the next screen after user creation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome, ${user.email}!")),
        );
      }
    }
  } catch (e) {
    // Display error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
  }
}
}
