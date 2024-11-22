import 'package:flutter/material.dart';

class InstructorsView extends StatefulWidget {
  const InstructorsView({super.key});

  @override
  State<InstructorsView> createState() => _InstructorsViewState();
}

class _InstructorsViewState extends State<InstructorsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'instructors hub',
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
              subtitle: Text('flutter instructor'),
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
