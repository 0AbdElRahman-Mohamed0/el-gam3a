import 'package:elgam3a/screens/courses_screen.dart';
import 'package:elgam3a/screens/profile_screen.dart';
import 'package:elgam3a/screens/schedule_screen.dart';
import 'package:elgam3a/widgets/leave_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  tabBorderRadius: 10,
                  gap: 8,
                  color: Theme.of(context).dividerColor,
                  activeColor: Theme.of(context).primaryColor,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 300),
                  tabBackgroundColor: Theme.of(context).dividerColor,
                  tabs: [
                    GButton(
                      icon: Icons.schedule,
                      text: 'Schedule',
                    ),
                    GButton(
                      icon: Icons.school,
                      text: 'Courses',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
