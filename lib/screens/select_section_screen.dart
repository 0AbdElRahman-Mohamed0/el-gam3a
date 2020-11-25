import 'package:elgam3a/notifier_providers/course_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectSectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courseDetails = context.watch<CourseNotifierProvider>().course;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${courseDetails.courseCode} Section',
          style: TextStyle(
            color: Color(0xFF2699FB),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: 66.0,
          left: 40,
          right: 40,
          top: MediaQuery.of(context).size.height / 4,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  '${courseDetails.courseCode} Section',
                  style: TextStyle(
                    color: Color(0xFF2699FB),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'it while be an easy semester with this course, hope you enjoy the section',
                  style: TextStyle(
                    color: Color(0xFF2699FB).withOpacity(0.65),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: courseDetails.courseAssistants.length,
                      itemBuilder: (context, index) {
                        return SectionDrs(
                          drName: courseDetails.courseAssistants[index],
                          description: 'teacher assistant, Cs',
                        );
                      }),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: () {},
                  color: Color(0xFF2699FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Text(
                      'Join',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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

class SectionDrs extends StatelessWidget {
  SectionDrs({
    this.description,
    this.drName,
  });
  final String drName;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Icon(Icons.person),
              radius: 20,
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  drName,
                  style: TextStyle(
                    color: Color(0xFF2699FB),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Color(0xFF2699FB),
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
