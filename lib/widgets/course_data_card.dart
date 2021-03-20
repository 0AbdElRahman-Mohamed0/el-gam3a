import 'package:elgam3a/providers/course_data_provider.dart';
import 'package:elgam3a/widgets/error_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class CourseDataCard extends StatelessWidget {
  final String type;
  CourseDataCard({this.type});
  _downloadPDF(BuildContext context) async {
    try {
      await Permission.storage.request();
      await context.read<CourseDataProvider>().downloadPDF();
    } catch (e, s) {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            ErrorPopUp(message: 'Something Went Wrong! please try again'),
      );
      print(e);
      print(s);
    }
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
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.download_outlined,
                      color: Theme.of(context).primaryColor,
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
