import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  final int level;
  final VoidCallback onTap;
  final int? index;
  final String studentRole;
  final String passLevel;
  final List levels;
  const LevelCard({
    super.key,
    required this.level,
    required this.onTap,
    this.index, required this.studentRole, required this.passLevel, required this.levels,
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
          passLevel == 'Level ${index! + 1}' || levels.contains('Level ${index! + 1}')
              ? const SizedBox() // Level is unlocked, no lock icon
              : Positioned(
            right: MediaQuery.of(context).size.width * 0.36,
            bottom: 10,
            child: Icon(
              Icons.lock,
              color: Colors.grey[700],
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}