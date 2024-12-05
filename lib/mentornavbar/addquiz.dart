import 'package:flutter/material.dart';

class AddQuestionForm extends StatefulWidget {
  const AddQuestionForm({Key? key}) : super(key: key);

  @override
  _AddQuestionFormState createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final _questionController = TextEditingController();
  final _answer1Controller = TextEditingController();
  final _answer2Controller = TextEditingController();
  final _answer3Controller = TextEditingController();
  String? _selectedLevel;
  int? _selectedPoints;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Add Question TextField
                TextField(
                  controller: _questionController,
                  decoration: InputDecoration(
                    hintText: 'Add Question..',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
        
                // Add Answer 1 TextField
                TextField(
                  controller: _answer1Controller,
                  decoration: InputDecoration(
                    hintText: 'Add Answer 1..',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
        
                // Add Answer 2 TextField
                TextField(
                  controller: _answer2Controller,
                  decoration: InputDecoration(
                    hintText: 'Add Answer 2..',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
        
                // Add Answer 3 TextField
                TextField(
                  controller: _answer3Controller,
                  decoration: InputDecoration(
                    hintText: 'Add Answer 3..',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
        
                // Choose Level Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedLevel,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'Choose Level',
                  ),
                  items: ['level 1', 'level 2', 'level 3']
                      .map((level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLevel = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
        
                // Points Selector Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildPointButton(5),
                    _buildPointButton(10),
                    _buildPointButton(20),
                  ],
                ),
                const SizedBox(height: 20),
        
                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointButton(int points) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedPoints == points ? Colors.blue : Colors.grey,
        shape: const StadiumBorder(),
      ),
      onPressed: () {
        setState(() {
          _selectedPoints = points;
        });
      },
      child: Text('$points Pts'),
    );
  }

  void _submitForm() {
    final question = _questionController.text;
    final answer1 = _answer1Controller.text;
    final answer2 = _answer2Controller.text;
    final answer3 = _answer3Controller.text;
    final level = _selectedLevel;
    final points = _selectedPoints;

    if (question.isEmpty ||
        answer1.isEmpty ||
        answer2.isEmpty ||
        answer3.isEmpty ||
        level == null ||
        points == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    // Perform the desired action, such as saving the data
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Question submitted successfully')),
    );
  }
}
