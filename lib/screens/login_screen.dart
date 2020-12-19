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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // To make app never resize when keyboard appear
        resizeToAvoidBottomInset: false,
        ////
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: LoginAppBar(
            title: Text('El-Gam3a'),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TabBar(
                // To make underline to the selected tab
                indicatorColor: kPrimaryColor,
                ////

                unselectedLabelColor: Colors.grey,
                labelColor: kSecondaryColor,
                labelStyle: TextStyle(
                  fontSize: 20.0,
                ),

                tabs: [
                  Tab(
                    text: 'Student',
                  ),
                  Tab(
                    text: 'Doctor',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Login(
                      accountType: 'student',
                    ),
                    Login(
                      accountType: 'doctor',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
