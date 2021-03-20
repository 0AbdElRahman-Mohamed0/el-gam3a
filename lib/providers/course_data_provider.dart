import 'package:elgam3a/models/course_data_model.dart';
import 'package:elgam3a/services/api.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class CourseDataProvider extends ChangeNotifier {
  CourseDataModel courseData;
  CourseDataProvider(this.courseData);
  final ApiProvider _api = ApiProvider.instance;

  Future<void> downloadPDF() async {
    await _api.downloadPDF(
        courseData.pdfUrl, 'Lecture ${courseData.number}\n${courseData.name}');
  }
}
