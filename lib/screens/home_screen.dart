import 'package:elgam3a/screens/courses_screen.dart';
import 'package:elgam3a/screens/profile_screen.dart';
import 'package:elgam3a/screens/schedule_screen.dart';
import 'package:elgam3a/widgets/leave_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    ScheduleScreen(),
    CoursesScreen(),
    ProfileScreen(),
  ];

  _youWantLeave() {
    showDialog(
      context: context,
      builder: (BuildContext context) => LeavePopUp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _youWantLeave(),
      child: Scaffold(
        appBar: AppBar(
          title: _selectedIndex == 0
              ? Text('My Schedule')
              : _selectedIndex == 1
                  ? Text('Courses')
                  : Text('Profile'),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.schedule),
              title: Text("Schedule"),
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.school),
              title: Text("Courses"),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
