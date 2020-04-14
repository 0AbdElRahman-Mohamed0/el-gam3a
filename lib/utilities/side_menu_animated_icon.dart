import 'package:flutter/material.dart';

class SideMenuAnimatedIcon extends StatefulWidget {
  SideMenuAnimatedIcon({@required this.drawerKey});
  final GlobalKey<ScaffoldState> drawerKey;
  @override
  _SideMenuAnimatedIconState createState() => _SideMenuAnimatedIconState();
}

class _SideMenuAnimatedIconState extends State<SideMenuAnimatedIcon>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> drawerKey;
  bool expanded = true;
  AnimationController myAnimation;

  @override
  void initState() {
    super.initState();
    drawerKey = widget.drawerKey;
    myAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
      reverseDuration: Duration(milliseconds: 350),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
    );
  }
}
