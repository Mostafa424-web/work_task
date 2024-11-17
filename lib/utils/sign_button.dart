import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final String text;
  final Function onPress;
  const SignButton({super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,),
      width: double.infinity,
      child: MaterialButton(
        onPressed:
            (){
          onPress();
        },
        color: const Color(0xff3D3BF3), // Button background color
        textColor: Colors.white, // Text color
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18, // Text size
            color: Colors.white, // Text color
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}