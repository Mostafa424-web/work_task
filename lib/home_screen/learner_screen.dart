import 'package:flutter/material.dart';

class LearnerScreen extends StatelessWidget {
  const LearnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learner Screen')),
      body: const Center(
        child: Text(
          'Welcome, Learner!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}