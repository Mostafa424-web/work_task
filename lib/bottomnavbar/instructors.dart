import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class InstructorsView extends StatefulWidget {
  const InstructorsView({super.key,required this.userData});
  final Map<String, dynamic>? userData;
  @override
  State<InstructorsView> createState() => _InstructorsViewState();
}

class _InstructorsViewState extends State<InstructorsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'instructors hub',
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: Rx.merge([
                  FirebaseFirestore.instance
                      .collection('users')
                      .where('role', isEqualTo: 'Flutter Instructor')
                      .snapshots(),
                  FirebaseFirestore.instance
                      .collection('users')
                      .where('role', isEqualTo: 'UI/UX Instructor')
                      .snapshots(),
                  FirebaseFirestore.instance
                      .collection('users')
                      .where('role', isEqualTo: 'Tester Instructor')
                      .snapshots(),
                ]),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text("No students found."));
                  }
                  final instructors = snapshot.data!.docs
                      .map((doc) => doc.data() as Map<String, dynamic>)
                      .toList();
                  return Expanded(
                    child: ListView.builder(
                      itemCount: instructors.length,
                      itemBuilder: (context, index) {
                        final instructor = instructors[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: ListTile(
                            title: Text(instructor['name']),
                            subtitle: Text(instructor['role']),
                            leading: const CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.amber,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                // on press open an alert dialog
                              },
                              icon: const Icon(
                                Icons.menu,
                              ),
                            ),
                            // open a dialog contains the social media links
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        )));
  }
}
