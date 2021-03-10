import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _isSignIn();
  }

  _isSignIn() async {
    await Future.delayed(Duration(seconds: 1));

    final signIn = context.read<AuthProvider>().isSignedIn();

    if (signIn) {
      await context.read<AuthProvider>().getUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF64668E).withOpacity(0.0), Color(0xFF64668E)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: SvgPicture.asset('assets/svg/splash.svg'),
          ),
        ),
      ),
    );
  }
}
