import 'package:flutter/material.dart';

class MentorScreen extends StatelessWidget {
  const MentorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mentor Screen')),
      body: const Center(
        child: Text(
          'Welcome, Mentor!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}