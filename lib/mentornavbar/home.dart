import 'package:flutter/material.dart';
import 'package:works/mentornavbar/addquiz.dart';

class AdminHomeScreenView extends StatefulWidget {
  @override
  State<AdminHomeScreenView> createState() => AdminHomeScreenViewState();
}

class AdminHomeScreenViewState extends State<AdminHomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            color: Colors.white,
            child: Column(
              children: [
                Text("welcome, let's start"),
                Divider(
                  color: Colors.blue,
                  indent: 50,
                  endIndent: 50,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => AddQuestionForm()));
                    },
                    child: Text('add quiz'))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
