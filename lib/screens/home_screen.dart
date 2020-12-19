import 'package:elgam3a/screens/courses_screen.dart';
import 'package:elgam3a/screens/schedule_screen.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ScheduleScreen(),
    CoursesScreen(),
    // Text(
    //   'Index 2: Home',
    // ),
    Text(
      'Index 3: Business',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: _selectedIndex == 0
            ? Text('My Schedule')
            : _selectedIndex == 1
                ? Text('Courses')
                : Text('Profile'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 90.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: Offset(0, -3),
              blurRadius: 6,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: kPrimaryColor, //Colors.white,
          selectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
          selectedIconTheme: IconThemeData(size: 24.0),
          selectedItemColor: Colors.white, //kSecondaryColor, //kPrimaryColor
          unselectedLabelStyle: TextStyle(
            fontSize: 10,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),
          unselectedIconTheme: IconThemeData(size: 24.0),
          unselectedItemColor: Color(0x80FFFFFF), //Colors.black45,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
