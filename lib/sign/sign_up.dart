import 'package:flutter/material.dart';
import '../utils/functions.dart';
import '../utils/sign_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();

class _SignUpState extends State<SignUp> {
  String? selectedRole;
  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> roles = ['Instructor', 'Learner', 'Mentor'];
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField<String>(
                value: selectedRole,
                hint: const Text('Select a role'),
                items: roles.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) async {
                  setState(() {
                    selectedRole = value;
                  });
                  print(selectedRole);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SignButton(
                text: 'Sign Up',
                onPress: () async {
                  await signUpWithEmailAndPassword(
                      nameController.text.trim(),
                      emailController.text.trim(),
                      passController.text.trim(),
                      context,
                      selectedRole);
                })
          ],
        ),
      ),
    );
  }
}
