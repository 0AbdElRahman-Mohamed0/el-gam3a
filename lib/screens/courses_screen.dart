import 'package:elgam3a/screens/register_courses_doctor.dart';
import 'package:elgam3a/screens/register_courses_student.dart';
import 'package:elgam3a/utilities/constants.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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
//                LoadingScreen.show(context);
//                await Future.delayed(
//                  Duration(seconds: 2),
//                );
//                Navigator.pop(context);
                pushNewScreen(
                  context,
                  screen: RegisterCoursesDoctor(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
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
