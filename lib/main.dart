import 'package:elgam3a/providers/courses_provider.dart';
import 'package:elgam3a/screens/splash_screen.dart';
import 'package:elgam3a/utilities/theme.dart';
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
        theme: AppTheme().lightTheme,
      ),
    );
  }
}
