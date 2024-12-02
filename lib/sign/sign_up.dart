import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../utils/functions.dart';
import '../utils/sign_button.dart';
import 'package:image_picker/image_picker.dart';

import 'login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController passRoleController = TextEditingController();

class _SignUpState extends State<SignUp> {
  String? selectedRole;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
  bool _isUploading = false;
  String? _image;


  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      // Generate a unique file name
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(_selectedImage!);

      // Wait for upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      _image = downloadUrl;
      print(_image);
      // // Save the URL to Firestore
      await FirebaseFirestore.instance.collection('users').doc('yourUserId').update({
        'image': downloadUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully!')),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    passRoleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> roles = [
      'Flutter Instructor',
      'Flutter Learner',
      'Flutter Mentor',
      'UI/UX Instructor',
      'UIUX Learner',
      'UI/UX Mentor',
      'Tester Instructor',
      'Tester Learner',
      'Tester Mentor'
    ];
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hello, Friend !',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Enter your personal details  \n and start journey with us',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 20,
                ),
                _selectedImage != null
                    ? Stack(
                        children: [
                          CircleAvatar(
                            radius: 75,
                            backgroundImage: FileImage(
                              _selectedImage!,
                              // fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: _pickImage, // Trigger image picker on tap
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.camera_alt_outlined,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          const CircleAvatar(
                            radius: 75,
                            child: Icon(Icons.person, size: 50),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: _pickImage, // Trigger image picker on tap
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.camera_alt_outlined,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: customInputDecoration(
                        hintText: "User name", icon: Icons.person_rounded),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: emailController,
                    validator: (emailController) {
                      if (isValidEmail(emailController!.trim(), context)) {
                        return 'email is valid';
                      } else {
                        return 'email is not valid';
                      }
                    },
                    decoration: customInputDecoration(
                        hintText: "email", icon: Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: customInputDecoration(
                        hintText: "password",
                        icon: Icons.lock,
                        suffix: Icons.remove_red_eye),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedRole,
                    hint: const Text('Select a role'),
                    items: roles.map((role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (value) async {
                      setState(() {
                        selectedRole = value;
                      });
                      print(selectedRole);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                selectedRole != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: passRoleController,
                          obscureText: true,
                          decoration: customInputDecoration(
                              hintText: "password of Your role",
                              icon: Icons.lock,
                              suffix: Icons.remove_red_eye),
                        ),
                      )
                    : const SizedBox(
                        height: 2,
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.black, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SignButton(
                  loading: loading,
                    text: loading ? const Center(child: CircularProgressIndicator(),) : const Text(
                      'Sign UP',
                      style: TextStyle(
                        fontSize: 28, // Text size
                        color: Colors.white, // Text color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPress: () async {
                      setState(() {
                        loading = true;
                      });
                      await signUpWithEmailAndPassword(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passController.text.trim(),
                          context,
                          selectedRole,
                          passRoleController.text.trim());
                      setState(() {
                        loading != loading;
                      });
                      await _uploadImage();
                      setState(() {
                        loading = false;
                      });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
