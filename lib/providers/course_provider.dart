import 'package:elgam3a/models/course_data_model.dart';
import 'package:elgam3a/models/course_model.dart';
import 'package:elgam3a/services/api.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class CourseProvider with ChangeNotifier {
  CourseModel course;
  CourseProvider(this.course);
  final ApiProvider _api = ApiProvider.instance;
  List<CourseDataModel> lectures;

  Future<void> getLectures() async {
    lectures = await _api.getLectures(course);
    lectures.sort((a, b) => a.number.compareTo(b.number));
    notifyListeners();
  }

  addLecture(CourseDataModel lecture) {
    lectures.add(lecture);
    notifyListeners();
  }
}
