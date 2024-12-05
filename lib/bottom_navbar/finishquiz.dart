import 'package:flutter/material.dart';

class FinishQuizScreen extends StatefulWidget {
  const FinishQuizScreen({super.key});

  @override
  State<FinishQuizScreen> createState() => _FinishQuizScreenState();
}

class _FinishQuizScreenState extends State<FinishQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('your result is 15'),
            Text('the wrong question was q2 15 pt'),
            Text('return to home'),
          ],
        ),
      ),
    );
  }
}
