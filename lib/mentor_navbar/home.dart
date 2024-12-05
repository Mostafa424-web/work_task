import 'package:flutter/material.dart';

class AdminHomeScreenView extends StatefulWidget {
  const AdminHomeScreenView({super.key});

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
                const Text("welcome, let's start"),
                const Divider(
                  color: Colors.blue,
                  indent: 50,
                  endIndent: 50,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) =>
                      AlertDialog(
                        title: const Text(
                          'Will Added Soon',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                                Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      )
                      );
                    },
                    child: const Text('add quiz'))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
