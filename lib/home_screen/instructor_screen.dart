import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InstructorScreen extends StatelessWidget {
  const InstructorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Instructor Screen')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('Your Role', isEqualTo: 'Learner')
            .snapshots(),
        builder: (context, snapshot) {
          // Check for errors or loading
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final learners = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: learners.length,
            itemBuilder: (context, index) {
              final learnerData = learners[index].data() as Map<String, dynamic>;

              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(learnerData['name']),
                subtitle: Text((learnerData['Number']).toString()),
                trailing: Text(learnerData['Your Role']),
              );
            },
          );
        },
      )
    );
  }
}