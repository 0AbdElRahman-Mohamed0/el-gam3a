import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(150),
                ),
              ),
              title: Text('El-Gam3a'),
              centerTitle: true,
              titleSpacing: 30.0,
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
//                  backgroundColor: Colors.red,
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
                      Icon(Icons.directions_car),
                      Icon(Icons.directions_transit),
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
