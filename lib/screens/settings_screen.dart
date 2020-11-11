import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'Settings Page',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
