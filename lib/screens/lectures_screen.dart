import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/course_data_provider.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/screens/add_course_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LecturesScreen extends StatefulWidget {
  @override
  _LecturesScreenState createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<AuthProvider>().user;
    final provider = context.watch<CourseProvider>();
    final course = provider.course;
    final lectures = provider.lectures;
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
                color: Theme.of(context).cardColor,
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
                        title: 'lecture',
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
      body: lectures?.isEmpty ?? true
          ? Center(
              child: Text('No Lectures'),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                children: lectures.map((lecture) {
                  return ChangeNotifierProvider<CourseDataProvider>(
                    create: (_) => CourseDataProvider(lecture),
                    child: CourseDataCard(
                      type: 'Lecture',
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}

class CourseDataCard extends StatelessWidget {
  final String type;
  CourseDataCard({this.type});
  _downloadPDF(BuildContext context) async {
    await Permission.storage.request();
    await context.read<CourseDataProvider>().downloadPDF();
  }

  @override
  Widget build(BuildContext context) {
    final courseData = context.watch<CourseDataProvider>().courseData;
    return Column(
      children: [
        InkWell(
          onTap: () => _downloadPDF(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$type ${courseData.number}',
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 16.0, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${courseData.name}',
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 16.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.filePdf,
                      color: Theme.of(context).cardColor,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.download_outlined,
                      color: Theme.of(context).cardColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
