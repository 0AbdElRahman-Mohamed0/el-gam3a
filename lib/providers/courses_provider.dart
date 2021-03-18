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

  Future<void> removeCourseGeneral(CourseModel course) async {
    await _api.removeCourseGeneral(course);
  }

  Future<void> getCourseGeneral() async {
    courses = await _api.getCourseGeneral();
    notifyListeners();
  }

  resetFilter() {
    filteredCourses = null;
    notifyListeners();
  }

  filterData(String facultyName, int hallID) async {
    await Future.delayed(Duration(milliseconds: 500));
    filteredCourses = List.of(courses.where((element) =>
        element.courseLocation == facultyName && element.courseHall == hallID));
    notifyListeners();
  }
}
