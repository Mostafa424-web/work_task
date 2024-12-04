import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

bool isValidEmail(String email, BuildContext context) {
  // Define the regex pattern for validating email ending with ".com"
  final RegExp emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  // Check if the email matches the general pattern
  if (!emailRegex.hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Email is valid."),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Ensure the email ends with ".com"
  return email.endsWith(".com");
}

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = Colors.black,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ),
  );
}

Future<User?> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
    context,
    String? role,
    String passwordRole) async {
  try {
    // Check if email, password or name is empty
    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        passwordRole.isEmpty) {
      showCustomSnackBar(message: 'Please enter all required fields.',context: context);
      return null;
    } else {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('pwdrole')
          .doc('passwords')
          .get();
      final passrole = docSnapshot.data();
      if ((role == 'Flutter Mentor' ||
              role == 'UI/UX Mentor' ||
              role == 'Tester Mentor' ||
              role == 'Flutter Learner' ||
              role == 'UIUX Learner' ||
              role == 'Tester Learner' ||
              role == 'Flutter Instructor' ||
              role == 'UI/UX Instructor' ||
              role == 'Tester Instructor') &&
          passwordRole == passrole![role]) {
        User? user = await signup_handle(email, password);
        Map<String, dynamic> userData = {
          'name': name,
          'email': email,
          'role': role,
          'created_at': FieldValue.serverTimestamp(),
          'uid': user!.uid,
          'completedLevels': [],
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(userData);
        Navigator.pushReplacementNamed(
          context,
          '/bottomNav',
          arguments: userData,
        );
        return user;
      } else {
        showCustomSnackBar(
            context: context,
            message: "Invalid role or password role selected.");
      }
    }
  } on FirebaseAuthException catch (e) {
    // Handle Firebase auth errors
    if (e.code == 'weak-password') {
      showCustomSnackBar(message: "The password provided is too weak.",context: context);
    } else if (e.code == 'email-already-in-use') {
      showCustomSnackBar(message: "The account already exists for that email.",context: context);
    } else if (e.code == 'invalid-email') {
      showCustomSnackBar(message: "The email address is not valid.",context: context);
    }
    return null;
  } catch (e) {
    print("Error: $e");
    return null;
  }
  return null;
}

Future<User?> signup_handle(String email, String password) async {
  UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  User? user = userCredential.user;
  return user;
}

Future<User?> signInWithEmailAndPassword(
    String email, String password, context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // Return the signed-in user
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    // Handle specific FirebaseAuth errors
    if (e.code == 'user-not-found') {
      print("No user found for that email.");
      throw Exception("No user found for that email.");
    } else if (e.code == 'wrong-password') {
      print("Wrong password provided.");
      throw Exception("Wrong password provided.");
    } else if (e.code == 'invalid-email') {
      print("Invalid email address.");
      throw Exception("Invalid email address.");
    } else {
      print("Unknown error: ${e.message}");
      throw Exception("Error: ${e.message}");
    }
  } catch (e) {
    // Handle any other errors
    print("An error occurred: $e");
    throw Exception("An error occurred. Please try again.");
  }
}
