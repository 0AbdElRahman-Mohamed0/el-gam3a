import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/providers/courses_provider.dart';
import 'package:elgam3a/providers/departments_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CourseChoosedCard extends StatelessWidget {
  _removeCourse(BuildContext context) async {
    try {
      final course = context.read<CourseProvider>().course;
      final user = context.read<AuthProvider>().user;
      if (user.courses.length != 1) {
        if (user.type.toLowerCase() == 'professor') {
          await Future.wait({
            context.read<DepartmentsProvider>().removeProfFromCourse(course),
            context.read<CoursesProvider>().removeCourseGeneral(course),
          });
        }
        context
            .read<DepartmentsProvider>()
            .updateDepHours(course: course, type: 1);
        context.read<AuthProvider>().removeCourse(course);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'network-request-failed') {
        print(' error ${e.code}');
        Alert(
          context: context,
          title: 'Please check your internet connection!',
          style: AlertStyle(
            alertElevation: 0,
          ),
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ).show();
      } else {
        Alert(
          context: context,
          title: '${e.message}',
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
    } catch (e) {
      Alert(
        context: context,
        title: 'Something wrong happened, please try again',
        buttons: [
          DialogButton(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).cardColor
                ]),
            child: Text(
              'Okay',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final course = context.watch<CourseProvider>().course;
    return Row(
      children: [
        InkWell(
          onTap: () => _removeCourse(context),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${course.courseCode}',
                          style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.w700),
                        ),
                        TextSpan(text: ' '),
                        TextSpan(
                          text: '${course.courseHours}hr',
                          style: Theme.of(context).textTheme.button.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .button
                                  .color
                                  .withOpacity(0.5),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700),
                        ),
                        TextSpan(text: ' '),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.clear,
                    size: 16.0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
