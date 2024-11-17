import 'package:flutter/material.dart';
import 'package:works/sign/sign_up.dart';

import '../utils/sign_button.dart';

class ChooseLog extends StatelessWidget {
  const ChooseLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9694FF),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'), // Path to your background image
            fit: BoxFit.fill, // Ensures the image covers the whole screen
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignButton(text: 'Sign Up', onPress: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()), // New screen
                );
              },),
              const SizedBox(height: 20,),
              SignButton(text: 'Log In',
                  onPress: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()), // New screen
                );})
            ],
          ),
        ),
      ),
    );
  }
}

