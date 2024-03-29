import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Color(0xFFF2F2F2),
    primaryColor: Color(0xff015C93),
    cardColor: Color(0xFF51A7D8), //ef7a85 //f28db1 //b768a2
    dividerColor: Color(0xFFBEE6FF).withOpacity(0.5),
    shadowColor: Color(0xFFBEE6FF),
    disabledColor: Color(0xFF515C6F),
    buttonColor: Color(0xFFE5E5ED),
    errorColor: Color(0xFFFF5858),
    fontFamily: 'Calibri',

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
      color: Color(0xFF2D83B6),
      textTheme: TextTheme(
        headline1: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 22,
            fontWeight: FontWeight.w700),
      ),
    ),

    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: Color(0xff015C93),
      ),
      headline2: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Color(0xff151719),
      ),
      headline3: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9DCBBA).withOpacity(0.7),
      ),
      headline4: TextStyle(
        color: Color(0xff2D83B6),
      ),
      headline5: TextStyle(
        color: Color(0xff015C93).withOpacity(0.5),
      ),
      bodyText1: TextStyle(
        color: Color(0xff050737),
      ),
      button: TextStyle(
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        color: Color(0xffBEE6FF),
      ),
      subtitle2: TextStyle(
        color: Colors.grey,
      ),
      caption: TextStyle(
        color: Colors.white.withOpacity(0.5),
      ),
    ),
//    textTheme: TextTheme(
//      // title
//      headline6: TextStyle(
//        fontFamily: 'Calibri',
//        fontSize: 26,
//        fontWeight: FontWeight.w700,
//        color: Color(0xFF425B53),
//      ),
//      ////
//
//      headline1: TextStyle(
//        fontFamily: 'Calibri',
//        fontSize: 16,
//        fontWeight: FontWeight.w400,
//        color: Color(0xFF425B53),
//      ),
//
//      headline2: TextStyle(
//        fontFamily: 'Calibri',
//        fontSize: 16,
//        fontWeight: FontWeight.w400,
//        color: Color(0xFF707070),
//      ),
//
//      headline3: TextStyle(
//        fontFamily: 'Calibri',
//        fontSize: 20,
//        fontWeight: FontWeight.w700,
//        color: Color(0xFFF9F9F9),
//      ),
//
//      headline4: TextStyle(
//        fontFamily: 'Calibri',
//        fontSize: 16,
//        fontWeight: FontWeight.w400,
//        color: Color(0xFFF9F9F9),
//      ),
//
//      headline5: TextStyle(
//        fontFamily: 'Calibri',
//        fontSize: 16,
//        fontWeight: FontWeight.w500,
//        color: Color(0xFF707070),
//      ),
//    ),
  );
}
