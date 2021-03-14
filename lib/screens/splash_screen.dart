import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/faculties_provider.dart';
import 'package:elgam3a/screens/home_screen.dart';
import 'package:elgam3a/widgets/error_pop_up.dart';
import 'package:firebase_core/firebase_core.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _isSignIn();
      _getFaculties();
    });
  }

  _isSignIn() async {
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
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  _getFaculties() async {
    try {
      await context.read<FacultiesProvider>().getFaculties();
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            message: 'Something went wrong, please try again \n ${e.message}'),
      );
    } catch (e, s) {
      print(e);
      print(s);
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            message:
                'Something went wrong, please try again \n ${e.toString()}'),
      );
    }
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
