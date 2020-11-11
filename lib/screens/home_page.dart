import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:elgam3a/widgets/week_day_picker.dart';
import 'package:selection_picker/selection_item.dart';
import '../utilities/side_menu_animated_icon.dart';
import 'package:elgam3a/widgets/side_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: drawerKey,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('My Schedule'),
//          leading: SideMenuAnimatedIcon(
//            drawerKey: drawerKey,
//          ),
        ),

        drawer: SideMenu(
          userName: 'Bedo',
        ),
        ///// Days buttons Picker widget
      ),
    );
  }
}
