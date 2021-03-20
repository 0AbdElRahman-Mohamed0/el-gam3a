import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/hall_provider.dart';
import 'package:elgam3a/screens/courses_screen.dart';
import 'package:elgam3a/screens/hall_schedule_screen.dart';
import 'package:elgam3a/screens/profile_screen.dart';
import 'package:elgam3a/screens/schedule_screen.dart';
import 'package:elgam3a/widgets/error_pop_up.dart';
import 'package:elgam3a/widgets/leave_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:quiver/strings.dart';

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

  _qrScan() async {
    await Permission.camera.request();
    final qrResult = await scanner.scan();
    if (isNotBlank(qrResult)) {
      if (qrResult.contains(',') &&
          (qrResult.contains('Moharem-Bek') ||
              qrResult.contains('El-Shatby') ||
              qrResult.contains('El-Anfoshy'))) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<HallProvider>(
              create: (_) => HallProvider(hallDetails: qrResult),
              child: HallScheduleScreen(),
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => ErrorPopUp(
            message: 'That qr code not defined.',
          ),
        );
      }
    }
  }

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
              ? Text(
                  'My Schedule',
                  style: Theme.of(context).appBarTheme.textTheme.headline1,
                )
              : _selectedIndex == 1
                  ? Text(
                      'Courses',
                      style: Theme.of(context).appBarTheme.textTheme.headline1,
                    )
                  : Text(
                      'Profile',
                      style: Theme.of(context).appBarTheme.textTheme.headline1,
                    ),
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: _qrScan,
              icon: Icon(Icons.qr_code_scanner),
            ),
          ],
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
