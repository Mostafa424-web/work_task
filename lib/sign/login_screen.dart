import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:works/home_screen/instructor_screen.dart';
import 'package:works/sign/sign_up.dart';
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
            const Text(
              'Welcome Back !',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const Text(
              'To keep connected with us  please  \n login with your personal info',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 70,
            ),
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
                decoration: customInputDecoration(
                    hintText: "email", icon: Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: customInputDecoration(
                    hintText: "password",
                    icon: Icons.lock,
                    suffix: Icons.remove_red_eye),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 15),
                    ),
                  ),
                  Text(
                    'Forget Password?',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
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
          String? role = userData?['role'];

          if (role == 'Flutter Learner' || role == 'UI/UX Learner' || role == 'Tester Learner') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LearnerScreen(userData: userData)),
            );
          } else if (role == 'Instructor') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const InstructorScreen()),
            );
          } else if (role == 'Mentor') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MentorScreen()),
            );
          } else {
            showCustomSnackBar(context: context, message: "Role is null.");
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
