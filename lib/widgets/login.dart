import 'package:elgam3a/screens/home_screen.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'input_text.dart';
import 'package:flrx_validator/flrx_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String univCode;
  String password;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  _login() async {
    if (!_formKey.currentState.validate()) {
      setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    LoadingScreen.show(context);
    await Future.delayed(
      Duration(seconds: 2),
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, right: 30.0, left: 30.0),
      child: Form(
        key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Text(
//              'Hello ${widget.accountType} have a nice day.',
//              style: kWelcomeTextStyle,
//            ),
            Center(
              child: Container(
                height: 100.0,
                width: 100.0,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: 36),
            InputText(
              validator: Validator(
                rules: [
                  RequiredRule(validationMessage: 'ID is required.'),
                  MinLengthRule(11,
                      validationMessage: 'ID should be 11 number.'),
                  MaxLengthRule(11,
                      validationMessage: 'ID should be 11 number.'),
                ],
              ),
              inputType: 'email',
              maxLength: 11,
              onSaved: (value) {
                univCode = value;
              },
            ),
            // Space
            kSizedBox,
            ////
            InputText(
              validator: Validator(
                rules: [
                  RequiredRule(validationMessage: 'Password is required.'),
                ],
              ),
              inputType: 'password',
              onSaved: (value) {
                password = value;
              },
            ),
            // Space
            kSizedBox,
            ////
            FlatButton(
              child: Text('Forgot your password ?'),
              textColor: kPrimaryColor,
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
                padding: kLoginButtonSize,
                color: kSecondaryColor,
                child: Text('Login'),
                textColor: kButtonTextColor,
                onPressed: () => _login(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
