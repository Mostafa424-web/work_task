import 'package:flutter/material.dart';

class AdminAttendanceView extends StatefulWidget {
  const AdminAttendanceView({super.key, required this.userData});
  final Map<String, dynamic>? userData;

  @override
  State<AdminAttendanceView> createState() => _AdminAttendanceViewState();
}

class _AdminAttendanceViewState extends State<AdminAttendanceView> {
  @override
  Widget build(BuildContext context) {
    // Example data
    final checkInDetails = [
      {
        "userName": widget.userData!['name'],
        "role": widget.userData!['role'],
        "dateTime": "mm/dd/yy : 12:15 PM"
      },
      {
        "userName": widget.userData!['name'],
        "role": widget.userData!['role'],
        "dateTime": "mm/dd/yy : 12:15 PM"
      },
      {
        "userName": "Ahmed Khaled",
        "role": "Mentor UI/UX",
        "dateTime": "mm/dd/yy : 12:15 PM"
      },
      {
        "userName": "Ahmed Khaled",
        "role": "Mentor UI/UX",
        "dateTime": "mm/dd/yy : 12:15 PM"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // when the mentor press open scanner
              // the package installed mobile scanner
              // after scanning the data will be submitted
            },
            icon: Icon(
              Icons.qr_code_2_outlined,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Check-in Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: checkInDetails.length,
                itemBuilder: (context, index) {
                  final detail = checkInDetails[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "User Name : ${detail['userName']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Role : ${detail['role']}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Data & Time : ${detail['dateTime']}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
