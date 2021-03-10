import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/screens/register_courses_doctor_screen.dart';
import 'package:elgam3a/screens/register_courses_student_screen.dart';
import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Registered Courses',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(
            height: 18,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
            color: Theme.of(context).cardColor,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => user.type.toLowerCase() == 'student'
                      ? RegisterCoursesStudentScreen()
                      : RegisterCoursesDoctorScreen(),
                ),
              );
            },
            child: Text(
              'Register',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
