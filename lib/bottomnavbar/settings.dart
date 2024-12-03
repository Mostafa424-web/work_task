import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:works/utils/sign_button.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.userData});
  final Map<String, dynamic>? userData;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  TextEditingController nameController = TextEditingController();
  bool readOnly = true;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the initial name value
    nameController = TextEditingController(text: widget.userData!['name']);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userData!['uid'])
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('Failed to load user data.'));
        }

        // Get user data dynamically from Firestore
        final userData = snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture and Name Section
                  Center(
                    child: Column(
                      children: [
                        const Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              /* backgroundImage: NetworkImage(
                              'firestore image'), */ // Replace with actual image URL
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 15,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userData['name'], // Display updated name dynamically
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userData['role'],
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // User Information Fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: TextFormField(
                      controller: nameController,
                      readOnly: readOnly,
                      decoration: InputDecoration(
                        labelText: 'User Name',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              readOnly = !readOnly;
                              if (readOnly) {
                                // Update Firestore only when exiting edit mode
                                updateNameInFirestore(nameController.text);
                              }
                            });
                          },
                          icon: const Icon(Icons.edit),
                          color: const Color(0xff4F94BF),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          size: 24,
                          color: Color(0xff4F94BF),
                        ),
                        fillColor: Colors.white.withOpacity(0.7),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildEditableField(
                    label: 'Password',
                    value: '**********',
                    onTap: () {
                      print('Edit password');
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildEditableField(
                    label: 'Email',
                    value: userData['email'],
                    onTap: () {
                      print('Edit email');
                    },
                  ),
                  const SizedBox(height: 50),
                  SignButton(
                    onPress: _logout,
                    text: 'Log Out',
                    loading: false,
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context,'/sign'); // Replace '/signup' with your Sign Up route
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out: $e')),
      );
    }
  }

  // Function to build editable fields
  Widget _buildEditableField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> updateNameInFirestore(String newName) async {
    try {
      if (widget.userData != null && widget.userData!['uid'] != null) {
        // Update the name in Firestore
        await FirebaseFirestore.instance
            .collection('users') // Adjust collection name as needed
            .doc(widget.userData!['uid']) // Document ID
            .update({'name': newName});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name updated successfully!')),
        );
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update name: $e')),
      );
    }
  }
}
