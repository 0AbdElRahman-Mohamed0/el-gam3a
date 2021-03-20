import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a/models/course_model.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/screens/chat_screen.dart';
import 'package:elgam3a/screens/lectures_screen.dart';
import 'package:elgam3a/screens/quizzes_screen.dart';
import 'package:elgam3a/screens/select_section_screen.dart';
import 'package:elgam3a/screens/sheets_screen.dart';
import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatefulWidget {
  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  final firestore = FirebaseFirestore.instance;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _selectChat(BuildContext context, CourseModel course) async {
    try {
      final chats = await firestore
          .collection('chats')
          .where('courseCode', isEqualTo: course.courseCode)
          .get();
      if (chats.docs.isEmpty) {
        final DocumentReference data = await firestore.collection('chats').add({
          'courseCode': course.courseCode,
          'created_at': DateTime.now(),
          'updated_at': DateTime.now()
        });
      }

      final provider = context.read<CourseProvider>();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ChangeNotifierProvider<CourseProvider>.value(
            value: provider,
            child: ChatScreen(),
          ),
        ),
      );
    } on FirebaseException catch (e) {
      print('$e');
    } catch (e) {
      print('$e');
    }
  }

  _getLectures(BuildContext context, CourseModel course) async {
    try {
      final lectures = await firestore
          .collection('each_course_data')
          .where('courseCode', isEqualTo: course.courseCode)
          .get();
      if (lectures.docs.isEmpty) {
        await firestore.collection('each_course_data').add({
          'courseCode': course.courseCode,
          'created_at': DateTime.now(),
          'updated_at': DateTime.now()
        });
      }

      final provider = context.read<CourseProvider>();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<CourseProvider>.value(
            value: provider,
            child: LecturesScreen(),
          ),
        ),
      );
    } on FirebaseException catch (e) {
      print('$e');
    } catch (e) {
      print('$e');
    }
  }

  _getQuizzes(BuildContext context, CourseModel course) async {
    try {
      final lectures = await firestore
          .collection('each_course_data')
          .where('courseCode', isEqualTo: course.courseCode)
          .get();
      if (lectures.docs.isEmpty) {
        await firestore.collection('each_course_data').add({
          'courseCode': course.courseCode,
          'created_at': DateTime.now(),
          'updated_at': DateTime.now()
        });
      }

      final provider = context.read<CourseProvider>();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<CourseProvider>.value(
            value: provider,
            child: QuizzesScreen(),
          ),
        ),
      );
    } on FirebaseException catch (e) {
      print('$e');
    } catch (e) {
      print('$e');
    }
  }

  _getSheets(BuildContext context, CourseModel course) async {
    try {
      final lectures = await firestore
          .collection('each_course_data')
          .where('courseCode', isEqualTo: course.courseCode)
          .get();
      if (lectures.docs.isEmpty) {
        await firestore.collection('each_course_data').add({
          'courseCode': course.courseCode,
          'created_at': DateTime.now(),
          'updated_at': DateTime.now()
        });
      }

      final provider = context.read<CourseProvider>();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<CourseProvider>.value(
            value: provider,
            child: SheetsScreen(),
          ),
        ),
      );
    } on FirebaseException catch (e) {
      print('$e');
    } catch (e) {
      print('$e');
    }
  }

  _getData() async {
    try {
      await Future.wait({
        context.read<CourseProvider>().getLectures(),
        context.read<CourseProvider>().getQuizzes(),
        context.read<CourseProvider>().getSheets(),
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final courseDetails = provider.course;
    final lectures = provider.lectures;
    final quizzes = provider.quizzes;
    final sheets = provider.sheets;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          '${courseDetails.courseCode}',
          style: Theme.of(context).appBarTheme.textTheme.headline1.copyWith(
                fontSize: 20,
              ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 32,
            color: Theme.of(context).appBarTheme.color,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        courseDetails.isRequired
                            ? Column(
                                children: [
                                  Text(
                                    'Required',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 16.0),
                                ],
                              )
                            : SizedBox(),
                        Text(
                          '${courseDetails.courseName}',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              fontSize: 22.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${courseDetails.courseCode}',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 22.0, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Doctor',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Text(
                                  'Dr ${courseDetails.courseDoctor}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Text(
                                  '${courseDetails.courseLocation}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text(
                              'Day',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '${courseDetails.courseDay}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Time',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '${courseDetails.courseTime}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Hall',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '(${courseDetails.courseHall}) - ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                Text(
                                  'Build',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '(${courseDetails.courseBuilding})',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Section',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider<CourseProvider>(
                                  create: (_) => CourseProvider(courseDetails),
                                  child: SelectSectionScreen(),
                                ),
                              ),
                            );
                          },
                          height: MediaQuery.of(context).size.height * 0.055,
                          color:
                              Theme.of(context).dividerColor.withOpacity(0.3),
                          buttonTitle: 'No section selected',
                          buttonTitleStyle:
                              Theme.of(context).textTheme.headline5.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                          tail: Text(
                            'Join section',
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  CustomButton(
                    height: MediaQuery.of(context).size.height * 0.065,
                    onPressed: () => _selectChat(context, courseDetails),
//                    tail: Container(
//                      height: 20,
//                      width: 20,
//                      decoration: BoxDecoration(
//                        color: Theme.of(context).primaryColor,
//                        borderRadius: BorderRadius.circular(30),
//                      ),
//                      child: Center(
//                        child: Text(
//                          '2',
//                          style: Theme.of(context).textTheme.button.copyWith(
//                                fontSize: 14,
//                                fontWeight: FontWeight.w400,
//                              ),
//                        ),
//                      ),
//                    ),
                    color: Colors.white,
                    buttonTitle: 'Community',
                    buttonTitleStyle:
                        Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    // height: MediaQuery.of(context).size.height * 0.09,
                    onPressed: () => _getLectures(context, courseDetails),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    buttonTitle: 'Lectures',
                    buttonSubTitle: '${lectures?.length ?? 0} Lectures',
                    buttonTitleStyle:
                        Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                    buttonSubTitleStyle:
                        Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    onPressed: () => _getQuizzes(context, courseDetails),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    buttonTitle: 'Quizzes',
                    buttonSubTitle: '${quizzes?.length ?? 0} Quizzes',
                    buttonTitleStyle:
                        Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                    buttonSubTitleStyle:
                        Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    onPressed: () => _getSheets(context, courseDetails),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    buttonTitle: 'Sheets',
                    buttonSubTitle: '${sheets?.length ?? 0} Sheets',
                    buttonTitleStyle:
                        Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                    buttonSubTitleStyle:
                        Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.27,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prerequisite',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InfoCard(
                          height: MediaQuery.of(context).size.height * 0.08,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.8),
                          courseTitle: 'Algorithms',
                          buttonTitleStyle:
                              Theme.of(context).textTheme.button.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                          courseCode: 'CS 302',
                          courseHours: 2,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InfoCard(
                          height: MediaQuery.of(context).size.height * 0.08,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.8),
                          courseTitle: 'Data Mining',
                          buttonTitleStyle:
                              Theme.of(context).textTheme.button.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                          courseCode: 'CS 420',
                          courseHours: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    this.height,
    this.buttonTitle,
    this.buttonSubTitle,
    this.buttonTitleStyle,
    this.buttonSubTitleStyle,
    this.tail,
    this.color,
    this.onPressed,
  });
  final double height;
  final String buttonTitle;
  final String buttonSubTitle;
  final TextStyle buttonTitleStyle;
  final TextStyle buttonSubTitleStyle;
  final Widget tail;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonSubTitle == null
                ? Text(
                    buttonTitle,
                    style: buttonTitleStyle,
                  )
                : Column(
                    children: [
                      Text(
                        buttonTitle,
                        style: buttonTitleStyle,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        buttonSubTitle,
                        style: buttonSubTitleStyle,
                      ),
                    ],
                  ),
            tail == null
                ? Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  )
                : Row(
                    children: [
                      tail,
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  InfoCard({
    this.height,
    this.courseTitle,
    this.buttonTitleStyle,
    this.courseCode,
    this.courseHours,
    this.color,
  });
  final double height;
  final String courseTitle;
  final String courseCode;
  final int courseHours;
  final TextStyle buttonTitleStyle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                '$courseTitle',
                style: buttonTitleStyle,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    '$courseCode',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '$courseHours hr',
                    style: Theme.of(context).textTheme.button.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Done',
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.lock,
                color: Colors.white.withOpacity(0.5),
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
