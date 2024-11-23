import 'package:flutter/material.dart';

class LeaderboardView extends StatefulWidget {
  @override
  _LeaderboardViewState createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  String selectedCategory = 'UI/UX'; // Default category

  // default data
  final List<Map<String, dynamic>> studentData = [
    {'name': 'Ahmed Hesham', 'category': 'UI/UX', 'score': 100},
    {'name': 'Sara Ali', 'category': 'Flutter', 'score': 95},
    {'name': 'Mohamed Salah', 'category': 'Testing', 'score': 90},
    {'name': 'Laila Mostafa', 'category': 'UI/UX', 'score': 85},
    {'name': 'Omar Khaled', 'category': 'Flutter', 'score': 80},
  ];

  @override
  Widget build(BuildContext context) {
    // Filter data based on the selected category
    final filteredData = studentData
        .where((student) => student['category'] == selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Selection Chips
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: ['UI/UX', 'Flutter', 'Testing'].map((category) {
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
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),

          // Student List
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final student = filteredData[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                        /* backgroundImage: NetworkImage(
                          'image from firestore'), */ // Replace with actual image URLs
                        ),
                    title: Text(student['name']),
                    subtitle: Text('${student['category']} - Level 1'),
                    trailing: Text('Score ${student['score']}'),
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
