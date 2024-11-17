import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'drop_down_menu.dart';
import 'navigator.dart';

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

InputDecoration customInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    fillColor: Colors.white.withOpacity(0.7),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}


Future<User?> signUpWithEmailAndPassword(String name, String email, String password, context) async {
  try {
    // Check if email, password or name is empty
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all required fields.')),
      );
      return null;
    } else {
      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null){
        // Save User to fireStore database
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'uid': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Navigate to the next screen after user creation
        Navigation.navigateAndRemoveAllNamed(context, MaterialPageRoute(builder: (context) => const DropDownMenuScreen()));
        return user;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create user.')),
        );
        return null;
      }
    }
  } on FirebaseAuthException catch (e) {
    // Handle Firebase auth errors
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The password provided is too weak.")),
      );
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The account already exists for that email.")),
      );
    } else if (e.code == 'invalid-email') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The email address is not valid.")),
      );
    }
    return null;
  } catch (e) {
    print("Error: $e");
    return null;
  }
}