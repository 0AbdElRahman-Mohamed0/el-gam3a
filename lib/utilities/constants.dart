import 'package:flutter/material.dart';

const kButtonTextColor = Colors.white;
const kPrimaryColor = Color(0xFF155E9F);
const kSecondaryColor = Color(0xFFF08220);
//const kSecondaryColor = Color(0xFFFA685E);

const kTitleTextStyle = TextTheme(
  title: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25.0,
  ),
);

const kButtonSize = EdgeInsets.only(
  left: 132.0,
  right: 132.0,
  top: 20.0,
  bottom: 20.0,
);

const kTextFieldCircularBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(18.0),
  ),
);

//const kSelectedTextFieldColor = OutlineInputBorder(
//  borderRadius: BorderRadius.all(
//    Radius.circular(18.0),
//  ),
//  borderSide: BorderSide(
//    color: kSecondaryColor,
//  ),
//);

const kTextFieldInputStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
);

const kSizedBox = SizedBox(
  height: 15.0,
);

const kWelcomeTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);
