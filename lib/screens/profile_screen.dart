import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'Profile Page',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}