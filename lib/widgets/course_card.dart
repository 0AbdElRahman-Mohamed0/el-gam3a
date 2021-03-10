import 'package:elgam3a/notifier_providers/course_provider.dart';
import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/screens/course_details_screen.dart';
import 'package:elgam3a/widgets/course_info_popup.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final provider = context.watch<CourseNotifierProvider>();
    final courseDetails = provider.course;
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
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor.withOpacity(0.3),
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
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 14.0, fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: '  ',
                      ),
                      TextSpan(
                        text: courseDetails.courseName,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 12.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                if (user.type.toLowerCase() == 'student') ...{
                  Text(
                    'Dr ${courseDetails?.courseDoctor}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 12.0, fontWeight: FontWeight.w700),
                  ),
                },
              ],
            ),
            Row(
              children: [
                if (user.type.toLowerCase() == 'student') ...{
                  if (courseDetails.required) ...{
                    Text(
                      'Required',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          fontSize: 12.0, fontWeight: FontWeight.w400),
                    ),
                  },
                },
                IconButton(
                  onPressed: () {
                    showDialog(
                      barrierColor: Colors.black.withOpacity(0.6),
                      context: context,
                      builder: (BuildContext context) =>
                          ChangeNotifierProvider<CourseNotifierProvider>.value(
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
