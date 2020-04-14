import 'package:flutter/material.dart';
import 'constants.dart';

class MyAppBar extends StatefulWidget {
  MyAppBar({@required this.drawerKey, @required this.title});
  final GlobalKey<ScaffoldState> drawerKey;
  final Text title;
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar>
    with SingleTickerProviderStateMixin {
  Text title;
  GlobalKey<ScaffoldState> drawerKey;
  bool expanded = true;
  AnimationController myAnimation;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    drawerKey = widget.drawerKey;
    myAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
      reverseDuration: Duration(milliseconds: 350),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: title,
      leading: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: myAnimation,
        ),
        onPressed: () {
          setState(() {
            drawerKey.currentState.openDrawer();
            expanded ? myAnimation.forward() : myAnimation.reverse();
            expanded = !expanded;
          });
        },
      ),
    );
  }
}
