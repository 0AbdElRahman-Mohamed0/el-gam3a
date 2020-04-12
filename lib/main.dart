import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_page.dart';

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

    return MaterialApp(
      theme: ThemeData.light(),
      home: LoginPage(),
    );
  }
}
