import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              title: Text(widget.title),
            ),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                TabBar(
                  indicator: BoxDecoration(
                    color: Colors.white,
                  ),
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
//                TabBarView(
//                  children: [
//                    Icon(Icons.directions_car),
//                    Icon(Icons.directions_transit),
//                  ],
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
