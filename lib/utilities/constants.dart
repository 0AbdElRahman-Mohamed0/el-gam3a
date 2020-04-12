import 'package:flutter/material.dart';

const kForgotPasswordColor = Colors.blue;
const kLoginButtonTextColor = Colors.white;
const kLoginButtonColor = Colors.blue;

const kPasswordFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.lock,
    color: Colors.blue,
  ),
  hintText: 'Password',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: Colors.blue,
    ),
  ),
);

const kStudentCodeFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.email,
    color: Colors.blue,
  ),
  hintText: 'University Number',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: Colors.blue,
    ),
  ),
);

const kDoctorCodeFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.email,
    color: Colors.blue,
  ),
  hintText: 'University Code',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: Colors.blue,
    ),
  ),
);

const kTextFieldInputStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
);

const kSizedBox = SizedBox(
  height: 15.0,
);

const kWelcomeTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.blue,
);
