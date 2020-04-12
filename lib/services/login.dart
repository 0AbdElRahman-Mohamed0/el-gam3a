import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class Login extends StatelessWidget {
  Login({@required this.accountType});

  final String accountType;
  String univCode;
  String password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, right: 30.0, left: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hello $accountType have a nice day.',
            style: kWelcomeTextStyle,
          ),
          kSizedBox,
          TextField(
            // This makes keyboard just numbers for this field
            keyboardType: TextInputType.number,
            ////
            style: kTextFieldInputStyle,
            decoration: accountType == 'student'
                ? kStudentCodeFieldDecoration
                : kDoctorCodeFieldDecoration,
            onChanged: (value) {
              univCode = value;
            },
          ),
          // Space
          kSizedBox,
          ////
          TextField(
            style: kTextFieldInputStyle,
            decoration: kPasswordFieldDecoration,
            onChanged: (value) {
              password = value;
            },
            // This makes password invisible
            obscureText: true,
            ////
          ),
          // Space
          kSizedBox,
          ////
          FlatButton(
            child: Text('Forgot your password ?'),
            textColor: kForgotPasswordColor,
            onPressed: () {},
          ),
          // Space
          kSizedBox,
          ////
          Center(
            child: RaisedButton(
              padding: EdgeInsets.only(
                left: 132.0,
                right: 132.0,
                top: 20.0,
                bottom: 20.0,
              ),
              color: kLoginButtonColor,
              child: Text('Login'),
              textColor: kLoginButtonTextColor,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
