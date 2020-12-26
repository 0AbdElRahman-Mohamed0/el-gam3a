import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({@required this.title});
  final Text title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(150),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: title,
      ),
      centerTitle: true,
    );
  }
}
