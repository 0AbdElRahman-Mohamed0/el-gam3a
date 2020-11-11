import 'package:elgam3a/screens/home_screen.dart';
import 'package:elgam3a/screens/login_screen.dart';
import 'package:elgam3a/screens/profile_screen.dart';
import 'package:elgam3a/screens/schedule_screen.dart';
import 'package:elgam3a/screens/settings_screen.dart';
import 'package:elgam3a/screens/splash_screen.dart';
import 'package:elgam3a/screens/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

final ThemeData lightTheme = ThemeData(
  backgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF155E9F),
    selectedLabelStyle: TextStyle(
      fontSize: 10,
      // fontFamily: 'Lato',
      fontWeight: FontWeight.w700,
    ),
    selectedIconTheme: IconThemeData(size: 24.0),
    selectedItemColor: Colors.white,
    unselectedLabelStyle: TextStyle(
      fontSize: 10,
      // fontFamily: 'Lato',
      fontWeight: FontWeight.w700,
    ),
    unselectedIconTheme: IconThemeData(size: 24.0),
    unselectedItemColor: Color(0x80FFFFFF),
    type: BottomNavigationBarType.fixed,
  ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // To prevent screen rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ////

    return MaterialApp(
      // home: HomeScreen(), ////// el mafrood LoginPage() bs e7na bngrb

      initialRoute: SplashScreen.id,
      routes: {
        ScheduleScreen.id: (context) => ScheduleScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
      theme: ThemeData.light(),
      home:
          ScheduleScreen(), //HomePage(), ////// el mafrood LoginPage() bs e7na bngrb
    );
  }
}
