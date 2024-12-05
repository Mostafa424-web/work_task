import 'package:flutter/material.dart';
import 'package:works/bottomnavbar/instructors.dart';
import 'package:works/bottomnavbar/leaderboard.dart';
import 'package:works/bottomnavbar/settings.dart';
import 'package:works/mentornavbar/attendance.dart';
import 'package:works/mentornavbar/home.dart';

class MentorBottomNavBarScreen extends StatefulWidget {
  const MentorBottomNavBarScreen({super.key, required this.userData});
  final Map<String, dynamic>? userData;

  @override
  State<MentorBottomNavBarScreen> createState() => _MentorBottomNavBarScreenState();
}

class _MentorBottomNavBarScreenState extends State<MentorBottomNavBarScreen> {
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
      AdminHomeScreenView(),
      AdminAttendanceView(userData: widget.userData,),
      LeaderboardView(userData: widget.userData,),
      InstructorsView(userData: widget.userData),
      SettingsView(userData: widget.userData,),
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
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
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
