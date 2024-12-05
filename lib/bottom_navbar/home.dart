import 'package:flutter/material.dart';
import 'package:works/bottom_navbar/quiz.dart';
import 'package:works/utils/firebase_utils.dart';
import 'package:works/utils/functions.dart';

import '../utils/level_card.dart';
import '../utils/user_info_display.dart';

class HomeScreenView extends StatefulWidget {

  const HomeScreenView({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  late List<String> levels = [];
  final TextEditingController passLevelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCompletedLevels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 16,
            right: 16,
            child: UserInfoDisplay(
              name: widget.userData['name'],
              role: widget.userData['role'],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: 12,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: LevelCard(
                      passLevel: '',
                      levels: levels,
                      level: index + 1,
                      onTap: () =>
                          _showPasswordDialog(context, index, widget.userData['role']),
                      index: index,
                      studentRole: widget.userData['role'],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _loadCompletedLevels() async {
    levels = await FirebaseUtils.getCompletedLevels(widget.userData['uid']);
    setState(() {});
  }

  void _showPasswordDialog(BuildContext context, int index, String role) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Password"),
          content: TextField(
            controller: passLevelController,
            decoration: const InputDecoration(hintText: "Enter level password"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final passwords = await FirebaseUtils.getLevelPasswords();
                final levelPassword = passwords?['Level ${index + 1}'];

                if (levelPassword == null ||
                    passLevelController.text.trim() != levelPassword) {
                  showCustomSnackBar(
                    context: context,
                    message: 'Your Password Incorrect',
                  );
                } else {
                  final level = 'Level ${index + 1}';
                  levels.add(level);
                  await FirebaseUtils.updateCompletedLevels(widget.userData['uid'], level);
                  passLevelController.clear();
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(level: level, role: role),
                    ),
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
