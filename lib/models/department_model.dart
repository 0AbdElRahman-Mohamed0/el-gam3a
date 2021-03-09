import 'package:elgam3a/models/course_model.dart';
import 'package:elgam3a/services/vars.dart';

class DepartmentModel {
  DepartmentModel({
    this.courses,
    this.departmentID,
    this.departmentName,
  });

  List<CourseModel> courses = [];
  String departmentID;
  String departmentName;

  DepartmentModel.fromMap(Map<String, dynamic> m) {
    if (m[DepartmentData.COURSES] != null)
      m[DepartmentData.COURSES]
          .forEach((e) => courses.add(CourseModel.fromMap(e)));
    departmentID = m[DepartmentData.ID];
    departmentName = m[DepartmentData.NAME];
  }
}
