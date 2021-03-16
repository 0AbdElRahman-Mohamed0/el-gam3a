import 'package:elgam3a/models/course_model.dart';
import 'package:elgam3a/services/api.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class CoursesProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider.instance;
  List<CourseModel> courses;
  List<CourseModel> filteredCourses;

  Future<void> addCourseGeneral(CourseModel course) async {
    await _api.addCourseGeneral(course);
  }

  Future<void> getCourseGeneral() async {
    courses = await _api.getCourseGeneral();
    notifyListeners();
  }

  filterData(String facultyName, int hallID) async {
    filteredCourses = null;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 500));a
    filteredCourses = List.of(courses.where((element) =>
        element.courseLocation == facultyName && element.courseHall == hallID));
    notifyListeners();
  }
}
