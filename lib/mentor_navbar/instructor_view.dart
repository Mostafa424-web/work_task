import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InstructorsViewStudent extends StatefulWidget {
  const InstructorsViewStudent({super.key, required this.userData});
  final Map<String, dynamic>? userData;

  @override
  _InstructorsViewStudentState createState() => _InstructorsViewStudentState();
}

class _InstructorsViewStudentState extends State<InstructorsViewStudent> {
  String selectedCategory = 'UIUX Learner'; // Default category
  List<Map<String, dynamic>> studentData = [];
  bool isLoading = true;
  final TextEditingController addPointsController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Selection Chips
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['UIUX Learner', 'Flutter Learner', 'Tester Learner']
                    .map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (isSelected) {
                        if (isSelected) {
                          setState(() {
                            selectedCategory = category;
                          });
                          fetchStudentsByCategory(category);
                        }
                      },
                    ),
                  ); //
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Student List
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('role', isEqualTo: selectedCategory)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No students found."));
                }
                final studentData = snapshot.data!.docs
                    .map((doc) => doc.data() as Map<String, dynamic>)
                    .toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: studentData.length,
                    itemBuilder: (context, index) {
                      final student = studentData[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: const CircleAvatar(
                              /* backgroundImage: NetworkImage(
                          'image from firestore'), */ // Replace with actual image URLs
                              ),
                          title: Text(student['name']),
                          subtitle: Text('${student['role']}'),
                          trailing:
                          ElevatedButton(
                            onPressed: () async {
                              showAddPointsDialog(context, student['uid']);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff0086CC)),
                            child: const Text(
                              'Add Points',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              })
        ],
      ),
    );
  }

  void showAddPointsDialog(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController pointsController = TextEditingController();
        return AlertDialog(
          title: const Text("Add Points"),
          content: TextField(
            controller: pointsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Enter points to add"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                int? pointsToAdd = int.tryParse(pointsController.text.trim());
                if (pointsToAdd == null) {
                  print("Invalid points input.");
                  return;
                }
                try {
                  final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

                  // Update Firestore using a transaction
                  await FirebaseFirestore.instance.runTransaction((transaction) async {
                    DocumentSnapshot snapshot = await transaction.get(userDoc);

                    if (!snapshot.exists) {
                      throw Exception("User does not exist!");
                    }

                    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

                    // Ensure the 'score' field exists
                    int currentScore = data?['score'] ?? 0;

                    transaction.update(userDoc, {'score': currentScore + pointsToAdd});
                  });

                  // Close the dialog
                  Navigator.pop(context);
                } catch (e) {
                  print("Error updating points: $e");
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }


  Future<void> fetchStudentsByCategory(String category) async {
    setState(() {
      isLoading = true;
    });

    try {
      // Query Firestore for students with the selected category
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users') // Firestore collection name
          .where('role', isEqualTo: category)
          .orderBy('created_at', descending: true)
          .get();

      // Extract data from Firestore
      final fetchedData = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      setState(() {
        studentData = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
}
