import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(50),
                ),
              ),
              title: Text(widget.title),
              bottom: TabBar(
//                labelColor: Colors.blue,
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
            ),
          ),
          body: Center(
            child: TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
              ],
            ),
//            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(
//                  'You have pushed the button this many times:',
//                ),
//                Text(
//                  '$_counter',
//                  style: Theme.of(context).textTheme.display1,
//                ),
//              ],
//            ),
//          ),
//          floatingActionButton: FloatingActionButton(
//            onPressed: _incrementCounter,
//            tooltip: 'Increment',
//            child: Icon(Icons.add),
//          ),
//        ),
          ),
        ),
      ),
    );
  }
}
