import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'input_text.dart';

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
          InputText(
            inputType: 'email',
            person: accountType,
            onChanged: (value) {
              univCode = value;
            },
          ),
          // Space
          kSizedBox,
          ////
          InputText(
            inputType: 'password',
            person: accountType,
            onChanged: (value) {
              password = value;
            },
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
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
