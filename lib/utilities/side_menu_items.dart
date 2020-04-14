import 'package:flutter/material.dart';

class SideMenuItems extends StatelessWidget {
  final IconData pageIcon;
  final String pageName;
  final Function onPressed;
  SideMenuItems({
    @required this.pageName,
    @required this.pageIcon,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Icon(pageIcon),
            SizedBox(
              width: 15.0,
            ),
            Text(pageName),
          ],
        ),
      ),
    );
  }
}
