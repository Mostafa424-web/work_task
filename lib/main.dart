import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:works/mentornavbar/tryqrcode.dart';
import 'package:works/sign/sign_up.dart';

import 'bottomnavbar/navbar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: QRScannerScreen(),
      //const SignUp(),
    );
  }
}
