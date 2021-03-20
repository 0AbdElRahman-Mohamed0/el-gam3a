import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/course_data_provider.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/screens/add_course_data_screen.dart';
import 'package:elgam3a/widgets/course_data_card.dart';
import 'package:flutter/material.dart';

class QuizzesScreen extends StatefulWidget {
  @override
  _QuizzesScreenState createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<AuthProvider>().user;
    final provider = context.watch<CourseProvider>();
    final course = provider.course;
    final quizzes = provider.quizzes;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              '${course.courseName}',
              style: Theme.of(context).appBarTheme.textTheme.headline1.copyWith(
                    fontSize: 20,
                  ),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '(${course.courseCode})',
              style: Theme.of(context)
                  .appBarTheme
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 12),
            ),
          ],
        ),
        actions: [
          if (currentUser.type.toLowerCase() == 'professor') ...{
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).cardColor
                    ]),
              ),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChangeNotifierProvider<CourseProvider>.value(
                      value: provider,
                      child: AddCourseDataScreen(
                        title: 'quiz',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          },
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: quizzes?.isEmpty ?? true
          ? Center(
              child: Text('No Quizzes'),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                children: quizzes.map((lecture) {
                  return ChangeNotifierProvider<CourseDataProvider>(
                    create: (_) => CourseDataProvider(lecture),
                    child: CourseDataCard(
                      type: 'Quiz',
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
