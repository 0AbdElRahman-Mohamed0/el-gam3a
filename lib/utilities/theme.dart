import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Color(0xFFF7F7F9),
    primaryColor: Color(0xff3A3B61),
    cardColor: Color(0xFFef7a85), //ef7a85 //f28db1 //b768a2
    dividerColor: Color(0xFFB0B1C6),
    shadowColor: Color(0xFF9397B8),
    disabledColor: Color(0xFF515C6F),
    buttonColor: Color(0xFFE5E5ED),
    errorColor: Color(0xFFFF5858),

    ///////////
//    primaryColor: Color(0xFF425B53),
//    buttonColor: Color(0xFFED9539),
//    accentColor: Color(0xFFDD7215),
//    focusColor: Color(0xFF6D8F8E),
//    dividerColor: Color(0xFF9A9B9B),
//    disabledColor: Color(0x61BAA8A4),
//    cardColor: Colors.white,
//    shadowColor: Color(0xFF000000).withOpacity(0.1),
    appBarTheme: AppBarTheme(
      color: Color(0xFF64668E),
    ),
//    bottomNavigationBarTheme: BottomNavigationBarThemeData(
//      backgroundColor: Color(0xFF155E9F),
//      selectedLabelStyle: TextStyle(
//        fontSize: 10,
//        // fontFamily: 'Lato',
//        fontWeight: FontWeight.w700,
//      ),
//      selectedIconTheme: IconThemeData(size: 24.0),
////      selectedItemColor: Colors.white,
//      unselectedLabelStyle: TextStyle(
//        fontSize: 10,
//        // fontFamily: 'Lato',
//        fontWeight: FontWeight.w700,
//      ),
//      unselectedIconTheme: IconThemeData(size: 24.0),
//      unselectedItemColor: Color(0x80FFFFFF),
//      type: BottomNavigationBarType.fixed,
//    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Color(0xff3A3B61),
      ),
      headline2: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Color(0xff151719),
      ),
      headline3: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFFef7a85).withOpacity(0.7),
      ),
      headline4: TextStyle(
        color: Color(0xff64668E),
//        fontFamily: 'Bahij TheSansArabic',
      ),
      bodyText1: TextStyle(
        color: Color(0xff050737),
      ),
      button: TextStyle(
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        color: Color(0xffB0B1C6),
      ),
    ),
  );
}
