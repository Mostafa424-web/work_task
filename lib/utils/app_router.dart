import 'package:flutter/material.dart';
import 'package:works/sign/sign_up.dart';

import '../bottomnavbar/navbar.dart';
import 'not_found_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/sign':
        return MaterialPageRoute(
          builder: (context) => SignUp(),
        );

      case '/bottomNav':
        final userData = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BottomNavBarScreen(userData: userData),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundScreen(),
        );
    }
  }
}
