import 'package:elgam3a/providers/course_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectSectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courseDetails = context.watch<CourseProvider>().course;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${courseDetails.courseCode} Section',
          style: Theme.of(context).appBarTheme.textTheme.headline1.copyWith(
                fontSize: 20,
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
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'it while be an easy semester with this course, hope you enjoy the section',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      alignment: Alignment.center,
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
                      child: Center(
                        child: Text(
                          'Join',
                          style: Theme.of(context).textTheme.button.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
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
