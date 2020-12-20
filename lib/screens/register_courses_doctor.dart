import 'package:elgam3a/widgets/register_course_doctor_widget.dart';
import 'package:elgam3a/widgets/register_course_student_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elgam3a/utilities/constants.dart';

class RegisterCoursesDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            'Register Your Courses',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      child: Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'CS 205',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                TextSpan(text: ' '),
                                TextSpan(
                                  text: '2hr',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                TextSpan(text: ' '),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.clear,
                              size: 16.0,
                              color: Colors.white,
                            ),
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: (MediaQuery.of(context).size.height * 100) / 667,
                      margin: EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0, left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'hours Registered',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: kPrimaryColor,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '10',
                                    style: TextStyle(
                                        color: kPrimaryColor, //Colors.black,
                                        fontSize: 48.0,
                                        fontWeight: FontWeight.w700),
                                  ),
//                                  TextSpan(
//                                    text: '/18',
//                                    style: TextStyle(
//                                        color: kPrimaryColor.withOpacity(
//                                            0.5), //Colors.black.withOpacity(0.4),
//                                        fontSize: 24.0,
//                                        fontWeight: FontWeight.w700),
//                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: (MediaQuery.of(context).size.height * 100) / 667,
                      margin: EdgeInsets.only(left: 8.0),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 12.0,
                            right: (MediaQuery.of(context).size.width * 34.0) /
                                375),
                        child: Row(
//                        crossAxisAlignment: CrossAxisAlignment,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Department',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'University',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '6',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(
                                        text: '/10',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '4',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(
                                        text: '/10',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TabBar(
                physics: NeverScrollableScrollPhysics(),
                labelPadding: EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
                indicator: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                labelColor: Color(0xFFFFFFFF),
                unselectedLabelColor: kPrimaryColor.withOpacity(0.5),
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                tabs: [
                  FittedBox(
                    child: Tab(
                      text: "Department",
                    ),
                  ),
                  FittedBox(
                    child: Tab(
                      text: "University",
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  RegisterCourseDoctorWidget(),
                  RegisterCourseDoctorWidget(),
                  // Center(
                  //   child: Text('Minor'),
                  // ),
                  // Center(
                  //   child: Text('College'),
                  // ),
                  // Center(
                  //   child: Text('University'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
