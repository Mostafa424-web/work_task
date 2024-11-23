import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => AttendanceViewState();
}

class AttendanceViewState extends State<AttendanceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              // this qr will contains ( username - role )
              // in the "data" parameter
              data: 'username - role',
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
