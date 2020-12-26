import 'package:elgam3a/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elgam3a/widgets/login.dart';
import 'package:elgam3a/widgets/login_app_bar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // To make app never resize when keyboard appear
      resizeToAvoidBottomInset: true,
      ////
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: LoginAppBar(
          title: Text(
            'El-Gam3a',
            style: Theme.of(context).textTheme.button.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Login(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
