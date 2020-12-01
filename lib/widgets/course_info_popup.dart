import 'package:elgam3a/notifier_providers/course_provider.dart';
import 'package:elgam3a/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseInfoPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courseDetails = context.watch<CourseNotifierProvider>().course;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2699FB).withOpacity(0.1),
            offset: Offset(0, 30),
            blurRadius: 30,
          ),
        ],
      ),
      margin: EdgeInsets.only(
        left: 24,
        right: 24,
        top: MediaQuery.of(context).size.height * 0.24,
        bottom: MediaQuery.of(context).size.height * 0.24,
      ),
      padding: EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: SvgPicture.asset(
                  'assets/svg/close.svg',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
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
                color: kPrimaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w400),
          ),
          Text(
            courseDetails.courseCode,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 16.0),
          Text(
            'Dr ${courseDetails.courseDoctor}',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 24.0),
          Text(
            'Location',
            style: TextStyle(
              color: kPrimaryColor.withOpacity(0.5),
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            courseDetails.courseLocation,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
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
                      color: kPrimaryColor.withOpacity(0.5),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    courseDetails.courseDay,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Time',
                    style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.5),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
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
                            color: kPrimaryColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'pm',
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
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
                      color: kPrimaryColor.withOpacity(0.5),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    courseDetails.courseHall.toString(),
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            'Prerequisite',
            style: TextStyle(
              color: kPrimaryColor.withOpacity(0.5),
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 50,
              ),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Machine Learning',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Cs 250',
                      style: TextStyle(
                        color: kPrimaryColor.withOpacity(0.5),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Algorithms',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Cs 301',
                      style: TextStyle(
                        color: kPrimaryColor.withOpacity(0.5),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Cs 305',
                      style: TextStyle(
                        color: kPrimaryColor.withOpacity(0.5),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}