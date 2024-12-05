import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key, required this.userData});
  final Map<String, dynamic>? userData;

  @override
  _LeaderboardViewState createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  String selectedCategory = 'UIUX Learner'; // Default category
  List<Map<String, dynamic>> studentData = [];
  bool isLoading = true;

  // default data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
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
                  // .orderBy('created_at', descending: true)
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
                          subtitle: Text('${student['role']} - Level 1'),
                          trailing: Text(
                            'Score \n ${student['score'] ?? '-'}',
                            style: const TextStyle(fontSize: 15),
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
