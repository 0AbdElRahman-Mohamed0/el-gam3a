import 'package:elgam3a/providers/courses_provider.dart';
import 'package:elgam3a/screens/course_details_screen.dart';
import 'package:elgam3a/screens/home_screen.dart';
import 'package:elgam3a/screens/login_screen.dart';
import 'package:elgam3a/screens/profile_screen.dart';
import 'package:elgam3a/screens/schedule_screen.dart';
import 'package:elgam3a/screens/settings_screen.dart';
import 'package:elgam3a/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoursesProvider>(
          create: (context) => CoursesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'El-Gam3a',
        home: SplashScreen(),

//      theme: ThemeData.light(),
      ),
    );
  }
}
