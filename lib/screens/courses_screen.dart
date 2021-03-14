import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/screens/professor_screens/register_courses_doctor_screen.dart';
import 'package:elgam3a/screens/student_screens/register_courses_student_screen.dart';
import 'package:elgam3a/widgets/course_card.dart';
import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    return Center(
      child: user.courses?.isEmpty ?? true
          ? NoCoursesWidget()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              user.type.toLowerCase() == 'student'
                                  ? RegisterCoursesStudentScreen()
                                  : RegisterCoursesDoctorScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.34),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                      child: Text(
                        'Add and remove',
                        style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MyCourses(),
                ),
              ],
            ),
    );
  }
}

class MyCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 24),
      itemCount: user.courses.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider<CourseProvider>(
          create: (context) => CourseProvider(user.courses[index]),
          child: CourseCard(
            viewDetails: true,
          ),
        );
      },
    );
  }
}

class NoCoursesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    return Column(
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
        InkWell(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => user.type.toLowerCase() == 'student'
                    ? RegisterCoursesStudentScreen()
                    : RegisterCoursesDoctorScreen(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF000000).withOpacity(0.34),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
            child: Text(
              'Register',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
