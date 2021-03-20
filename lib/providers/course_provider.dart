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
  List<CourseDataModel> quizzes;
  List<CourseDataModel> sheets;

  Future<void> getLectures() async {
    lectures = await _api.getLectures(course);
    lectures.sort((a, b) => a.number.compareTo(b.number));
    notifyListeners();
  }

  addLecture(CourseDataModel lecture) {
    if (lectures == null) {
      lectures = [];
    }
    lectures.add(lecture);
    notifyListeners();
  }

  Future<void> getQuizzes() async {
    quizzes = await _api.getQuizzes(course);
    quizzes.sort((a, b) => a.number.compareTo(b.number));
    notifyListeners();
  }

  addQuiz(CourseDataModel lecture) {
    if (quizzes == null) {
      quizzes = [];
    }
    quizzes.add(lecture);
    notifyListeners();
  }

  Future<void> getSheets() async {
    sheets = await _api.getSheets(course);
    sheets.sort((a, b) => a.number.compareTo(b.number));
    notifyListeners();
  }

  addSheet(CourseDataModel lecture) {
    if (sheets == null) {
      sheets = [];
    }
    sheets.add(lecture);
    notifyListeners();
  }
}
