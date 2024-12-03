import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final bool loading;
  const SignButton({super.key, required this.text, required this.onPress, required this.loading});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,),
      width: double.infinity,
      child: MaterialButton(
        onPressed: (){
           onPress();
        },
        color: const Color(0xff4F94BF), // Button background color
        textColor: Colors.white, // Text color
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8), // Padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Rounded corners
        ),
        child: loading ? const Center(child: CircularProgressIndicator(),) : Text(
          text,
          style: const TextStyle(
            fontSize: 28, // Text size
            color: Colors.white, // Text color
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}