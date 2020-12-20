import 'package:elgam3a/notifier_providers/course_provider.dart';
import 'package:elgam3a/providers/courses_provider.dart';
import 'package:elgam3a/screens/course_details_screen.dart';
import 'package:elgam3a/utilities/constants.dart';
import 'package:elgam3a/widgets/course_info_popup.dart';
import 'package:flutter/material.dart';

class RegisterCourseStudentWidget extends StatefulWidget {
  @override
  _RegisterCourseStudentWidgetState createState() =>
      _RegisterCourseStudentWidgetState();
}

class _RegisterCourseStudentWidgetState
    extends State<RegisterCourseStudentWidget> {
  _getCourses() {
    context.read<CoursesProvider>().getCourses();
  }

  @override
  void initState() {
    super.initState();
    _getCourses();
  }

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CoursesProvider>().courses;
    return Scaffold(
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider<CourseNotifierProvider>(
            create: (context) => CourseNotifierProvider(courses[index]),
            child: CourseCard(),
          );
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courseDetails = context.watch<CourseNotifierProvider>().course;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<CourseNotifierProvider>(
            create: (_) => CourseNotifierProvider(courseDetails),
            child: CourseDetailsScreen(),
          ),
        ),
      ),
      child: Container(
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
                        text: courseDetails.courseCode,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: '  ',
                      ),
                      TextSpan(
                        text: courseDetails.courseName,
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
                  'Dr ' + courseDetails.courseDoctor,
                  style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.5),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            courseDetails.required
                ? Row(
                    children: [
                      Text(
                        'Required',
                        style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400),
                      ),
                      // SizedBox(width: 4.0),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            barrierColor: Colors.black.withOpacity(0.6),
                            context: context,
                            builder: (BuildContext context) =>
                                ChangeNotifierProvider<CourseNotifierProvider>(
                              create: (_) =>
                                  CourseNotifierProvider(courseDetails),
                              child: CourseInfoPopUp(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.info,
                          color: kPrimaryColor,
                          size: 20.0,
                        ),
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: () {
                      showDialog(
                        barrierColor: Colors.black.withOpacity(0.6),
                        context: context,
                        builder: (BuildContext context) =>
                            ChangeNotifierProvider<CourseNotifierProvider>(
                          create: (_) => CourseNotifierProvider(courseDetails),
                          child: CourseInfoPopUp(),
                        ),
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
      ),
    );
  }
}
