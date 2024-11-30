import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key, required this.level, required this.role})
      : super(key: key);

  final String level;
  final String role;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0; // Track the user's score
  String? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        stream: FirebaseFirestore.instance
            .collection('flutterquiz') // Your collection name
            .doc('level1') // Your document ID
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error occurred'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Document does not exist'));
          }

          final Map<String, dynamic>? questionsMap =
          snapshot.data!.data() as Map<String, dynamic>?;
          if (questionsMap == null || questionsMap.isEmpty) {
            return const Center(child: Text('No questions available.'));
          }

          final List<MapEntry<String, dynamic>> questions =
          questionsMap.entries.toList();
          final String currentQuestion = questions[_currentQuestionIndex].key;
          final Map<String, dynamic> options =
              questions[_currentQuestionIndex].value;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Welcome! Get ready to do your best",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.blue,
                  thickness: 2,
                  indent: 100,
                  endIndent: 100,
                ),
                SizedBox(height: 20),
                // Display the current question
                Text(
                  currentQuestion,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Display options
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: options.entries.map((entry) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAnswer = entry.key; // Mark selected answer
                        });
                      },
                      child: AnswerOption(
                        text: '${entry.value}',
                        isSelected: _selectedAnswer == entry.key,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                // "Next" button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_selectedAnswer == null) {
                        // Show a Snackbar if no answer is selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select an answer before proceeding."),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return; // Exit the function to prevent moving to the next question
                      }
                      if(_selectedAnswer == "5" ||
                          _selectedAnswer == "10" ||
                          _selectedAnswer == "30"){
                        _score += int.parse(_selectedAnswer!);
                        FirebaseFirestore.instance
                        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({'score': _score});
                      }
                      setState(() {
                        if (_currentQuestionIndex < questions.length - 1) {
                          _currentQuestionIndex++; // Move to the next question
                          _selectedAnswer = null; // Reset selected answer
                        } else {
                          // Show a message or navigate to another screen when quiz ends
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Quiz Completed!"),
                              content:  Text(
                                """You have reached the end of the quiz.
                                Your Score is $_score;
                                    """,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _currentQuestionIndex < questions.length - 1
                        ? "Next"
                        : "Finish",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                /* 
                - at the end of the questions show a dialog contains 
                - [ score - wrong question was q2 - the answer was c - 
                return home
                ]
                 */
              ],
            ),
          );
        },
      ),
    );
  }
}

class AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;

  const AnswerOption({Key? key, required this.text, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
