import 'package:elgam3a/screens/register_courses.dart';
import 'package:elgam3a/utilities/constants.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Registered Courses',
            style: kTextFieldInputStyle,
          ),
          Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              padding: kLoginButtonSize.copyWith(
                  left: 50, right: 50, top: 15, bottom: 15),
              color: Theme.of(context).buttonColor,
              textColor: kButtonTextColor,
              onPressed: () async {
                LoadingScreen.show(context);
                await Future.delayed(
                  Duration(seconds: 2),
                );
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterCourses(),
                  ),
                );
              },
              child: Text('Register'),
            ),
          ),
        ],
      ),
    );
  }
}
