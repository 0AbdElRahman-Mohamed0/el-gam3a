import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/screens/home_screen.dart';
import 'package:elgam3a/utilities/constants.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/input_text.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elgam3a/widgets/login_app_bar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    await context.read<AuthProvider>().logIn(univCode, password);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: LoginAppBar(
          title: Text('El-Gam3a'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              SizedBox(
                height: 15.0,
              ),
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
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                child: Text('Forgot your password ?'),
                textColor: kPrimaryColor,
                onPressed: () {},
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Theme.of(context).buttonColor,
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  textColor: kButtonTextColor,
                  onPressed: () => _login(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
