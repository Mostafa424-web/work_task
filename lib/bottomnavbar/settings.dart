import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.userData});
  final Map<String, dynamic>? userData;
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          /*  backgroundImage: NetworkImage(
                              'firestore image'), // Replace with actual image URL */
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
                    SizedBox(height: 8),
                    Text(
                      widget.userData!['name'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.userData!['role'],
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // User Information Fields
              _buildEditableField(
                label: 'User name',
                value: widget.userData!['name'],
                onTap: () {
                  print('Edit username');
                },
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
                value: widget.userData!['email'],
                onTap: () {
                  print('Edit email');
                },
              ),
            ],
          ),
        ),
      ),
    );
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
          style: TextStyle(
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
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: onTap,
            ),
          ),
        ),
      ],
    );
  }
}