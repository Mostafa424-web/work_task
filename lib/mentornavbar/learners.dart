import 'package:flutter/material.dart';

class StudentsView extends StatefulWidget {
  const StudentsView({super.key});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'students hub',
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text('shehab elsherif'),
              subtitle: Text('flutter learner'),
              leading: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.amber,
              ),
              trailing: IconButton(
                onPressed: () {
                  // on press open an alert dialog
                },
                icon: Icon(
                  Icons.menu,
                ),
              ),
              // open a dialog contains the social media links
            )
          ],
        )));
  }
}
