import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/providers/departments_provider.dart';
import 'package:elgam3a/screens/course_details_screen.dart';
import 'package:elgam3a/screens/professor_screens/choose_course_time_screen.dart';
import 'package:elgam3a/widgets/course_info_popup.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final bool viewDetails;
  CourseCard({this.viewDetails = false});

  _addCourse(BuildContext context) {
    final provider = context.read<CourseProvider>();
    final course = provider.course;
    final user = context.read<AuthProvider>().user;
    context
        .read<DepartmentsProvider>()
        .updateDepHours(course: course, user: user, type: 0);
    context.read<AuthProvider>().addCourse(course);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final provider = context.watch<CourseProvider>();
    final course = provider.course;
    return course.show == false
        ? SizedBox()
        : (user.type.toLowerCase() == 'student' &&
                course.courseDoctor == null &&
                !viewDetails)
            ? SizedBox()
            : (user.type.toLowerCase() == 'professor' &&
                    course.courseDoctor != null &&
                    !viewDetails)
                ? SizedBox()
                : GestureDetector(
                    onTap: viewDetails
                        ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider<
                                    CourseProvider>.value(
                                  value: provider,
                                  child: CourseDetailsScreen(),
                                ),
                              ),
                            )
                        : () => user.type.toLowerCase() == 'student'
                            ? _addCourse(context)
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider<
                                      CourseProvider>.value(
                                    value: provider,
                                    child: ChooseCourseTimeScreen(),
                                  ),
                                ),
                              ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      margin: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 10.0),
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
                                      text: course.courseCode,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .copyWith(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700),
                                    ),
                                    TextSpan(
                                      text: '  ',
                                    ),
                                    TextSpan(
                                      text: course.courseName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .copyWith(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.0),
                              if (user.type.toLowerCase() == 'student') ...{
                                Text(
                                  'Dr ${course?.courseDoctor}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700),
                                ),
                              },
                            ],
                          ),
                          Row(
                            children: [
                              if (user.type.toLowerCase() == 'student') ...{
                                if (course.isRequired) ...{
                                  Text(
                                    'Required',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                  ),
                                },
                              },
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    barrierColor: Colors.black.withOpacity(0.6),
                                    context: context,
                                    builder: (BuildContext context) =>
                                        ChangeNotifierProvider<
                                            CourseProvider>.value(
                                      value: provider,
                                      child: CourseInfoPopUp(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.info,
                                  color: Theme.of(context).primaryColor,
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
