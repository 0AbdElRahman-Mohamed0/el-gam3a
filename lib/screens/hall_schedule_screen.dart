import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/providers/courses_provider.dart';
import 'package:elgam3a/providers/hall_provider.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:flutter/material.dart';

class HallScheduleScreen extends StatefulWidget {
  @override
  _HallScheduleScreenState createState() => _HallScheduleScreenState();
}

class _HallScheduleScreenState extends State<HallScheduleScreen> {
  @override
  void initState() {
    super.initState();
    _resetFilter();
    _filterData();
  }

  _resetFilter() {
    context.read<CoursesProvider>().resetFilter();
  }

  _filterData() {
    final facultyName = context.read<HallProvider>().hallDetails.split(',')[0];
    final hall = context.read<HallProvider>().hallDetails.split(',')[1];
    context.read<CoursesProvider>().filterData(facultyName, num.parse(hall));
  }

  @override
  Widget build(BuildContext context) {
    final facultyName = context.watch<HallProvider>().hallDetails.split(',')[0];
    final hall = context.watch<HallProvider>().hallDetails.split(',')[1];
    final filteredCourses = context.watch<CoursesProvider>().filteredCourses;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Hall $hall',
              style: Theme.of(context).appBarTheme.textTheme.headline1,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '($facultyName)',
              style: Theme.of(context)
                  .appBarTheme
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
      body: filteredCourses == null
          ? Center(
              child: LoadingWidget(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              child: Column(
                children: filteredCourses
                    .map(
                      (course) => ChangeNotifierProvider<CourseProvider>(
                        create: (_) => CourseProvider(course),
                        child: HallScheduleCard(),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}

class HallScheduleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final course = context.watch<CourseProvider>().course;
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${course.courseName}', //'Machine learning'
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                '${course.courseTime}',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          Text(
            'Dr. ${course.courseDoctor}',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
