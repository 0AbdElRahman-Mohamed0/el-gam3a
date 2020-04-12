import 'package:elgam3a/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/login.dart';
import '../services/my_app_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          // To make app never resize when keyboard appear
          resizeToAvoidBottomInset: false,
          ////
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: MyAppBar(
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
      ),
    );
  }
}
