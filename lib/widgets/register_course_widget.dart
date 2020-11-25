import 'package:elgam3a/utilities/constants.dart';
import 'package:elgam3a/widgets/required_courses_popup.dart';
import 'package:flutter/material.dart';

class RegisterCourseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: (MediaQuery.of(context).size.height * 53.0) / 667.0,
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6.0),
        ),
        margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Cs 205',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: '   ',
                      ),
                      TextSpan(
                        text: 'Machine Learning',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Dr. Reham - Dr.  Nermin',
                  style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.5),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Required',
                  style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.5),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(width: 10.0),
                IconButton(
                  onPressed: () {
                    showDialog(
                      barrierColor: Colors.black.withOpacity(0.6),
                      context: context,
                      builder: (BuildContext context) => RequiredCoursesPopUp(),
                    );
                  },
                  icon: Icon(
                    Icons.info,
                    color: kPrimaryColor,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
