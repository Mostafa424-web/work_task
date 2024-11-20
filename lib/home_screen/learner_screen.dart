import 'package:flutter/material.dart';

class LearnerScreen extends StatelessWidget {
  const LearnerScreen({super.key, required this.userData});

    final Map<String, dynamic>? userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learner Screen')),
      body: ListTile(
                leading: const Icon(Icons.person),
                title: Text(userData!['name'] ?? 'Your Name'),
                subtitle: Text((userData!['number']).toString() ?? 'N/A'),
                trailing: Text(userData!['Your Role'] ?? 'Role'),
              ),
    );
  }
}
