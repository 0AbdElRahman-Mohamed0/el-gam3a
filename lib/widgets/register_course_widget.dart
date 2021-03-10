import 'package:elgam3a/notifier_providers/course_provider.dart';
import 'package:elgam3a/notifier_providers/department_provider.dart';
import 'package:elgam3a/providers/courses_provider.dart';
import 'package:elgam3a/widgets/course_card.dart';
import 'package:flutter/material.dart';

class RegisterCourseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final department = context.watch<DepartmentNotifierProvider>().department;
    return Scaffold(
      body: department.courses.isEmpty
          ? Center(
              child: Text(
              'No Courses Yet',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 14.0, fontWeight: FontWeight.w700),
            ))
          : ListView.builder(
              itemCount: department.courses.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider<CourseNotifierProvider>(
                  create: (context) =>
                      CourseNotifierProvider(department.courses[index]),
                  child: CourseCard(),
                );
              },
            ),
    );
  }
}
