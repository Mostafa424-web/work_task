import 'package:flutter/material.dart';

class Navigation {
  // Navigate using New Screen
  static void navigateToScreen(BuildContext context, Route routeName) {
    Navigator.pushReplacement(context, routeName);
  }

  // Navigate and remove all previous screens
  static void navigateAndRemoveAllNamed(BuildContext context, Route routeName) {
    Navigator.pushAndRemoveUntil(
      context,
      routeName,
          (Route<dynamic> route) => false,
    );
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
