import 'package:flutter/material.dart';

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
