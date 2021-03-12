import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/providers/departments_provider.dart';
import 'package:flutter/material.dart';

class CourseChoosedCard extends StatelessWidget {
  _removeCourse(BuildContext context) {
    final course = context.read<CourseProvider>().course;
    context.read<DepartmentsProvider>().updateDepHours(course: course, type: 1);
    context.read<AuthProvider>().removeCourse(course);
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
              color: Theme.of(context).cardColor,
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
                              fontSize: 12.0, fontWeight: FontWeight.w700),
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
                              fontSize: 12.0,
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
