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
            preferredSize: Size.fromHeight(120.0),
            child: MyAppBar(
              title: Text('El-Gam3a'),
            ),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                TabBar(
                  indicator: BoxDecoration(
                    color: Colors.white,
                  ),
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.blue,
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
