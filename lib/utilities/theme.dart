import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF425B53),
    buttonColor: Color(0xFFED9539),
    accentColor: Color(0xFFDD7215),
    focusColor: Color(0xFF6D8F8E),
    dividerColor: Color(0xFF9A9B9B),
    cardColor: Colors.white,
    shadowColor: Color(0xFF000000).withOpacity(0.1),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF155E9F),
      selectedLabelStyle: TextStyle(
        fontSize: 10,
        // fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
      ),
      selectedIconTheme: IconThemeData(size: 24.0),
//      selectedItemColor: Colors.white,
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
}
