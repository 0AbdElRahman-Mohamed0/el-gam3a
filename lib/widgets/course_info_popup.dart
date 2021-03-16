import 'package:elgam3a/providers/course_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseInfoPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final courseDetails = provider.course;
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: MediaQuery.of(context).size.height * 0.24,
        bottom: MediaQuery.of(context).size.height * 0.24,
      ),
      contentPadding:
          EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0, left: 16.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            child: SvgPicture.asset(
              'assets/svg/close.svg',
              color: Theme.of(context).primaryColor,
              width: 24,
              height: 24,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.52,
          width: MediaQuery.of(context).size.width - 48,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF000000).withOpacity(0.1),
                offset: Offset(0, 30),
                blurRadius: 30,
              ),
            ],
          ),
//            margin: EdgeInsets.only(
//              left: 24,
//              right: 24,
//              top: MediaQuery.of(context).size.height * 0.24,
//              bottom: MediaQuery.of(context).size.height * 0.24,
//            ),
//            padding:
//                EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0, left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              courseDetails.isRequired
                  ? Column(
                      children: [
                        Text(
                          'Required',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    )
                  : SizedBox(),
              Text(
                '${courseDetails.courseName}',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontSize: 22.0, fontWeight: FontWeight.w400),
              ),
              Text(
                '${courseDetails.courseCode}',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 22.0, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.0),
              Text(
                'Dr ${courseDetails.courseDoctor}',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontSize: 16.0, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16.0),
              Text(
                'Location',
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              Text(
                "${courseDetails?.courseLocation}",
                style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    'Day',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    '${courseDetails?.courseDay}',
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Time',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        courseDetails.courseTime,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Hall',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '(${courseDetails.courseHall}) - ',
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text(
                        'Build',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '(${courseDetails.courseBuilding})',
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 16.0,
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
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          'Cs 250',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: 14.0,
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
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          'Cs 301',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: 14.0,
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
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          'Cs 305',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: 14.0,
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
        ),
      ),
    );
  }
}
