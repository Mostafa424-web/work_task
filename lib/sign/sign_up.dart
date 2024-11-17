import 'package:flutter/material.dart';
import '../utils/functions.dart';
import '../utils/sign_button.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: nameController,
                decoration: customInputDecoration("enter your name"),
              ),
            ),
            const SizedBox(height: 20),
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
                  return null;
                },
                decoration: customInputDecoration("enter your email"),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: passController,
                obscureText: true,
                decoration: customInputDecoration("enter your password"),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SignButton(
                text: 'Sign Up',
                onPress: () {
                  signUpWithEmailAndPassword(nameController.text.trim(),emailController.text.trim(),
                      passController.text.trim(), context);
                })
          ],
        ),
      ),
    );
  }
}
