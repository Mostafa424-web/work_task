import 'package:flutter/material.dart';
import 'package:works/bottom_navbar/attendance.dart';
import 'package:works/bottom_navbar/home.dart';
import 'package:works/bottom_navbar/instructors.dart';
import 'package:works/bottom_navbar/leaderboard.dart';
import 'package:works/bottom_navbar/settings.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key, required this.userData});
  final Map<String, dynamic>? userData;

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  /*
  NOTE: when i move these above the override it works 
  when it was after the build {
  it doesnt't work 
  search on it 
  }
  
   */
  late List<Widget> screens;

  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      HomeScreenView(userData: widget.userData!),
      AttendanceView(userData: widget.userData),
      LeaderboardView(userData: widget.userData,),
      InstructorsView(userData: widget.userData),
      SettingsView(userData: widget.userData),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.blueGrey,
        items: const [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'attendance',
            icon: Icon(
              Icons.show_chart,
            ),
          ),
          BottomNavigationBarItem(
            label: 'leaderboard',
            icon: Icon(
              Icons.leaderboard,
            ),
          ),
          BottomNavigationBarItem(
            label: 'instructors',
            icon: Icon(
              Icons.people,
            ),
          ),
          BottomNavigationBarItem(
            label: 'settings',
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
