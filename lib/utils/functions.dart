import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../bottomnavbar/navbar.dart';

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

InputDecoration customInputDecoration(
    {required String hintText, required IconData icon, IconData? suffix}) {
  return InputDecoration(
    hintText: hintText,
    suffixIcon: Icon(
      suffix,
      color: const Color(0xff4F94BF),
    ),
    prefixIcon: Icon(
      icon,
      size: 24,
      color: const Color(0xff4F94BF),
    ),
    fillColor: Colors.white.withOpacity(0.7),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

Future<User?> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
    context,
    String? role,
    File? image,
    String passwordRole) async {
  int currentNumber = 1;
  try {
    // Check if email, password or name is empty
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all required fields.')),
      );
      return null;
    } else {
      if ((role == 'Flutter Learner' ||
              role == 'UI/UX Learner' ||
              role == 'Tester Learner') &&
          passwordRole == '444') {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;
        Map<String, dynamic> userData = {
          'number': currentNumber,
          'name': name,
          'email': email,
          'role': role,
          'created_at': FieldValue.serverTimestamp(),
          'uid': user!.uid,
          'image': image ?? '',
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(userData);
        currentNumber = currentNumber + 1;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavBarScreen(
                    userData: userData,
                  )),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome, ${user.email}!")),
        );
        return user;
      } else if ((role == 'Flutter Instructor' ||
              role == 'UI/UX Instructor' ||
              role == 'Tester Instructor') &&
          passwordRole == '555') {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;
        Map<String, dynamic> userData = {
          'number': currentNumber,
          'name': name,
          'email': email,
          'role': role,
          'created_at': FieldValue.serverTimestamp(),
          'uid': user!.uid,
          'image': image ?? '',
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(userData);
        currentNumber = currentNumber + 1;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavBarScreen(
                    userData: userData,
                  )),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome, ${user.email}!")),
        );
        return user;
      } else if ((role == 'Flutter Mentor' ||
              role == 'UI/UX Mentor' ||
              role == 'Tester Mentor') &&
          passwordRole == '666') {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;
        Map<String, dynamic> userData = {
          'number': currentNumber,
          'name': name,
          'email': email,
          'role': role,
          'created_at': FieldValue.serverTimestamp(),
          'uid': user!.uid,
          'image': image ?? '',
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(userData);
        currentNumber = currentNumber + 1;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavBarScreen(
                    userData: userData,
                  )),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome, ${user.email}!")),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The password provided is too weak.")),
      );
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("The account already exists for that email.")),
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
  return null;
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
