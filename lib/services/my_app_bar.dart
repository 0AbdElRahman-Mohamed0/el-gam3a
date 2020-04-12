import 'package:elgam3a/utilities/constants.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({@required this.title});
  final Text title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
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
      textTheme: kTitleTextStyle,
    );
  }
}
