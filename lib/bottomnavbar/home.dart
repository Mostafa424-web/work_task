import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:works/bottomnavbar/quiz.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key, required this.userData});
  final Map<String, dynamic>? userData;
  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

String passLevel = '';

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // Positioned text in the top-right corner
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end, // Align text to the right
                children: [
                  Text(
                    "Hello: ${widget.userData!['name']}", // Replace "Username" dynamically
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4), // Small space between the texts
                  Text(
                    "role: ${widget.userData!['role']}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main content: Levels
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center content horizontally
            children: [
              Flexible(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: LevelCard(
                            level: index + 1,
                            onTap: () => showPasswordDialog(context, index,'${widget.userData!['role']}'),
                            index: index, studentRole: '${widget.userData!['role']}',),
                      );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LevelCard extends StatelessWidget {
  final int level;
  final VoidCallback onTap;
  final int? index;
  final String studentRole;
  const LevelCard({
    super.key,
    required this.level,
    required this.onTap,
    this.index, required this.studentRole,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff0086CC),
              borderRadius: BorderRadius.circular(150),
            ),
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Text(
                'Level $level',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          passLevel != 'Level ${index! + 1}'
              ? Positioned(
                  right: MediaQuery.of(context).size.width * 0.4,
                  bottom: 10,
                  child: Icon(
                    Icons.lock, // Example icon, replace if needed
                    color: Colors.grey[700],
                    size: 20,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

final TextEditingController passLevelController = TextEditingController();

void showPasswordDialog(BuildContext context, int index, String roleStudent) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Enter Password"),
        content: TextField(
          controller: passLevelController,
          decoration: const InputDecoration(
            hintText: "Enter level password",
          ),
          onChanged: (value) {
            passLevel = passLevelController.text.trim();
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              // Perform validation
              DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
                  .collection('pwdrole')
                  .doc('password_level') // Firestore collection name
                  .get();
              Map<String, dynamic>? data =
                  docSnapshot.data() as Map<String, dynamic>?;
              if (data == null || data['Level ${index + 1}'] == null) {
                print('Field does not exist');
                return;
              } else if (passLevelController.text.trim() ==
                  data['Level ${index + 1}']) {
                print('Password correct for Level ${index + 1}');
                passLevel = 'Level ${index + 1}';
                print(passLevel);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen(level: passLevel,role: roleStudent,)),
                );
              } else {
                print('Incorrect Pass');
              }
            },
            child: const Text("Submit"),
          ),
        ],
      );
    },
  );
}
