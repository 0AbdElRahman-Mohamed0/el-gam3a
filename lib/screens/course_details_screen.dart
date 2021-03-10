import 'package:elgam3a/notifier_providers/course_provider.dart';
import 'package:elgam3a/screens/select_section_screen.dart';
import 'package:elgam3a/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CourseDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courseDetails = context.watch<CourseNotifierProvider>().course;
    return Scaffold(
      backgroundColor: Color(0xFFF1F9FF),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(courseDetails.courseCode),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 32,
            color: kPrimaryColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.37,
                    padding: EdgeInsets.all(24),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        courseDetails.required
                            ? Column(
                                children: [
                                  Text(
                                    'Required',
                                    style: TextStyle(
                                        color: kPrimaryColor.withOpacity(0.5),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 16.0),
                                ],
                              )
                            : SizedBox(),
                        Text(
                          courseDetails.courseName,
                          style: TextStyle(
                            color: Color(0xFF2699FB),
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          courseDetails.courseCode,
                          style: TextStyle(
                            color: Color(0xFF2699FB),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Doctor',
                                  style: TextStyle(
                                    color: Color(0xFF2699FB).withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Dr ' + courseDetails.courseDoctor,
                                  style: TextStyle(
                                    color: Color(0xFF2699FB),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location',
                                  style: TextStyle(
                                    color: Color(0xFF2699FB).withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  courseDetails.courseLocation,
                                  style: TextStyle(
                                    color: Color(0xFF2699FB),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Day',
                                  style: TextStyle(
                                    color: Color(0xFF2699FB).withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  courseDetails.courseDay,
                                  style: TextStyle(
                                    color: Color(0xFF2699FB),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Time',
                                  style: TextStyle(
                                    color: Color(0xFF2699FB).withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: courseDetails.courseTime,
                                        style: TextStyle(
                                          color: Color(0xFF2699FB),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'pm',
                                        style: TextStyle(
                                          color: Color(0xFF2699FB),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Hall',
                                  style: TextStyle(
                                    color: Color(0xFF2699FB).withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  courseDetails.courseHall.toString(),
                                  style: TextStyle(
                                    color: Color(0xFF2699FB),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Section',
                          style: TextStyle(
                            color: Color(0xFF2699FB),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider<
                                    CourseNotifierProvider>(
                                  create: (_) =>
                                      CourseNotifierProvider(courseDetails),
                                  child: SelectSectionScreen(),
                                ),
                              ),
                            );
                          },
                          height: MediaQuery.of(context).size.height * 0.055,
                          color: Color(0xFFBCE0FD).withOpacity(0.5),
                          buttonTitle: 'No section selected',
                          buttonTitleStyle: TextStyle(
                            color: Color(0xFF2699FB).withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          tail: Text(
                            'Join section',
                            style: TextStyle(
                              color: Color(0xFF2699FB),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  CustomButton(
                    height: MediaQuery.of(context).size.height * 0.065,
                    onPressed: () {},
                    tail: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Color(0xFF2699FB),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    color: Colors.white,
                    buttonTitle: 'Community',
                    buttonTitleStyle: TextStyle(
                      color: Color(0xFF2699FB),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    height: MediaQuery.of(context).size.height * 0.065,
                    onPressed: () {},
                    color: Colors.white,
                    buttonTitle: 'Lectures',
                    buttonSubTitle: '10 Lectures',
                    buttonTitleStyle: TextStyle(
                      color: Color(0xFF2699FB),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    buttonSubTitleStyle: TextStyle(
                      color: Color(0xFF2699FB).withOpacity(0.5),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    height: MediaQuery.of(context).size.height * 0.065,
                    onPressed: () {},
                    color: Colors.white,
                    buttonTitle: 'Quizzes',
                    buttonTitleStyle: TextStyle(
                      color: Color(0xFF2699FB),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    height: MediaQuery.of(context).size.height * 0.065,
                    onPressed: () {},
                    color: Colors.white,
                    buttonTitle: 'Sheets',
                    buttonTitleStyle: TextStyle(
                      color: Color(0xFF2699FB),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFBCE0FD).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prerequisite',
                          style: TextStyle(
                            color: Color(0xFF2699FB),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InfoCard(
                          height: MediaQuery.of(context).size.height * 0.07,
                          color: Color(0xFF2699FB),
                          courseTitle: 'Algorithms',
                          buttonTitleStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          courseCode: 'CS 302',
                          courseHours: 2,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InfoCard(
                          height: MediaQuery.of(context).size.height * 0.07,
                          color: Color(0xFF2699FB),
                          courseTitle: 'Data Mining',
                          buttonTitleStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          courseCode: 'CS 420',
                          courseHours: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    this.height,
    this.buttonTitle,
    this.buttonSubTitle,
    this.buttonTitleStyle,
    this.buttonSubTitleStyle,
    this.tail,
    this.color,
    this.onPressed,
  });
  final double height;
  final String buttonTitle;
  final String buttonSubTitle;
  final TextStyle buttonTitleStyle;
  final TextStyle buttonSubTitleStyle;
  final Widget tail;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonSubTitle == null
                ? Text(
                    buttonTitle,
                    style: buttonTitleStyle,
                  )
                : Column(
                    children: [
                      Text(
                        buttonTitle,
                        style: buttonTitleStyle,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        buttonSubTitle,
                        style: buttonSubTitleStyle,
                      ),
                    ],
                  ),
            tail == null
                ? Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF2699FB),
                    size: 15,
                  )
                : Row(
                    children: [
                      tail,
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF2699FB),
                        size: 15,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  InfoCard({
    this.height,
    this.courseTitle,
    this.buttonTitleStyle,
    this.courseCode,
    this.courseHours,
    this.color,
  });
  final double height;
  final String courseTitle;
  final String courseCode;
  final int courseHours;
  final TextStyle buttonTitleStyle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                courseTitle,
                style: buttonTitleStyle,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    courseCode,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '$courseHours hr',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Done',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.lock,
                color: Colors.white.withOpacity(0.5),
                size: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
