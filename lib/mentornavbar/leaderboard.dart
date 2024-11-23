import 'package:flutter/material.dart';

class AdminLeaderboardView extends StatefulWidget {
  const AdminLeaderboardView({super.key});

  @override
  State<AdminLeaderboardView> createState() => _AdminLeaderboardViewState();
}

class _AdminLeaderboardViewState extends State<AdminLeaderboardView> {
  @override
  Widget build(BuildContext context) {
    // Example list of students
    final students = List.generate(
      6,
      (index) => {
        "name": "Ahmed Hesham",
        "role": "UI/UX - Level 1 - 10",
        "imageUrl":
            "https://via.placeholder.com/150" // Replace with actual image URLs
      },
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Students",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Profile Image
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(student['imageUrl']!),
                          ),
                          const SizedBox(width: 16),

                          // Name and Role
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student['name']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  student['role']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Add Points Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              // this will open a dialog
                              // dialog contains text field
                              // the mentor will add the points
                              // and then hit submit
                              // Handle Add Points Action
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Points added for ${student['name']}",
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Add Points",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
