import 'package:flutter/material.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key, required this.userData});
  final Map<String, dynamic>? userData;
  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(height: 4), // Small space between the texts
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
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center content horizontally
              children: [
                // Level 1 with overlay image
                Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // open alert dialog
                        showPasswordDialog(context);
                        // enter level password
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff0086CC),
                          borderRadius: BorderRadius.circular(49)
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Text(
                            'Level 1',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 15,
                        /*  backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150', // Replace with actual image URL
                        ), */
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                // Level 2
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: Text(
                    'Level 2',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // Level 3
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: Text(
                    'Level 3',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


void showPasswordDialog(BuildContext context) {
  final TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Enter Password"),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle cancel action
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle password submission
              final enteredPassword = passwordController.text;
              Navigator.of(context).pop(); // Close the dialog
              print("Password entered: $enteredPassword");
            },
            child: const Text("Submit"),
          ),
        ],
      );
    },
  );
}
