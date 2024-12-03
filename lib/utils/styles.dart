import 'package:flutter/material.dart';

class AppStyles {
  ButtonStyle buildStyleFromElevated() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      padding: const EdgeInsets.symmetric(
          horizontal: 40, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  InputDecoration customInputDecoration(
      {required String hintText, required IconData icon, IconData? suffix , Function? onTap}) {
    return InputDecoration(
      hintText: hintText,
      suffixIcon: IconButton(
        onPressed: (){
          onTap!();
        },
        icon: Icon(
          suffix,
          color: const Color(0xff4F94BF),
        ),
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
}