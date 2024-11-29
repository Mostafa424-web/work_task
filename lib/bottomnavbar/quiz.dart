import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Text
                Column(
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
                    Text(
                      "What is the difference between UI and UX?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                // Options
                Column(
                  children: [
                    AnswerOption(
                      text:
                          "UI is about how the product looks, while UX is about how it works and feels. Both work together to create a seamless and engaging product.",
                    ),
                    SizedBox(height: 10),
                    AnswerOption(
                      text:
                          "UI is about the functionality of a product, and UX is about the visual design.",
                    ),
                    SizedBox(height: 10),
                    AnswerOption(
                      text:
                          "UX is only concerned with the usability of a product, while UI handles the interaction design.",
                    ),
                    SizedBox(height: 10),
                    AnswerOption(
                      text:
                          "UI is about the content structure, and UX is about the code behind the product.",
                    ),
                  ],
                ),
                // Next Button
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for "Next" button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
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
          ),
        ),
      ),
    );
  }
}

class AnswerOption extends StatelessWidget {
  final String text;

  const AnswerOption({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
