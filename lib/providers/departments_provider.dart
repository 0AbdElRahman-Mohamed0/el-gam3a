import 'package:elgam3a/models/department_model.dart';
import 'package:elgam3a/services/api.dart';
import 'package:flutter/material.dart';

import '../models/course_model.dart';
import '../models/department_model.dart';
import '../models/user_model.dart';

export 'package:provider/provider.dart';

class DepartmentsProvider with ChangeNotifier {
  final ApiProvider _api = ApiProvider.instance;
  DepartmentModel majorDepartment;
  DepartmentModel minorDepartment;
  DepartmentModel university;
  DepartmentModel college;
  int majorDepartmentHours = 0;
  int minorDepartmentHours = 0;
  int universityHours = 0;
  int collegeHours = 0;

  Future<void> getCoursesDataByMajorDepartmentName(
      String departmentName) async {
    majorDepartment = null;
    majorDepartment = await _api.getCoursesDataByDepartmentName(departmentName);
    notifyListeners();
  }

  Future<void> getCoursesDataByMinorDepartmentName(
      String departmentName) async {
    minorDepartment = null;
    minorDepartment = await _api.getCoursesDataByDepartmentName(departmentName);
    notifyListeners();
  }

  Future<void> getCoursesDataGeneral() async {
    university = null;
    university = await _api.getCoursesDataByDepartmentName('University');
    college = null;
    college = await _api.getCoursesDataByDepartmentName('College');
    notifyListeners();
  }

  Future<void> updateCourse(UserModel user) async {
    for (CourseModel course in user.courses) {
      if (majorDepartment != null) {
        if (majorDepartment.courses
                .where((element) => element.courseCode == course.courseCode)
                ?.isNotEmpty ??
            false) {
          final tmp = majorDepartment.courses
              .firstWhere((element) => element.courseCode == course.courseCode);
          if (user.type.toLowerCase() == 'professor') {
            tmp.courseDoctor = '${user.name}';
          } else {
            tmp.students.add(user.name);
          }

          await updateEachCourse(tmp, majorDepartment);
        }
      }

      if (minorDepartment != null) {
        if (minorDepartment.courses
                .where((element) => element.courseCode == course.courseCode)
                ?.isNotEmpty ??
            false) {
          final tmp = minorDepartment.courses
              .firstWhere((element) => element.courseCode == course.courseCode);
          if (user.type.toLowerCase() == 'professor') {
            tmp.courseDoctor = '${user.name}';
          } else {
            tmp.students.add(user.name);
          }

          await updateEachCourse(tmp, minorDepartment);
        }
      }

      if (college.courses
          .where((element) => element.courseCode == course.courseCode)
          .isNotEmpty) {
        final tmp = college.courses
            .firstWhere((element) => element.courseCode == course.courseCode);
        if (user.type.toLowerCase() == 'professor') {
          tmp.courseDoctor = '${user.name}';
        } else {
          tmp.students.add(user.name);
        }

        await updateEachCourse(tmp, college);
      }

      if (university.courses
              .where((element) => element.courseCode == course.courseCode)
              ?.isNotEmpty ??
          false) {
        final tmp = university.courses
            .firstWhere((element) => element.courseCode == course.courseCode);
        if (user.type.toLowerCase() == 'professor') {
          tmp.courseDoctor = '${user.name}';
        } else {
          tmp.students.add(user.name);
        }

        await updateEachCourse(tmp, university);
      }
    }
    notifyListeners();
  }

  Future<void> updateEachCourse(
      CourseModel course, DepartmentModel department) async {
    department.courses.removeWhere((e) => e.courseCode == course.courseCode);
    department.courses.add(course);
    await _api.updateCourse(department.courses, department.departmentID);
    notifyListeners();
  }

  getDepHours(CourseModel course, UserModel user) async {
    if (user.courses
        .where((element) => element.courseCode == course.courseCode)
        .isNotEmpty) {
      return;
    }
    if (majorDepartment != null) {
      if (majorDepartment.courses
              .where((element) => element.courseCode == course.courseCode)
              ?.isNotEmpty ??
          false) {
        majorDepartmentHours += course.courseHours;
        notifyListeners();
        return;
      }
    }

    if (minorDepartment != null) {
      if (minorDepartment.courses
              .where((element) => element.courseCode == course.courseCode)
              ?.isNotEmpty ??
          false) {
        minorDepartmentHours += course.courseHours;
        notifyListeners();
        return;
      }
    }

    if (college.courses
        .where((element) => element.courseCode == course.courseCode)
        .isNotEmpty) {
      collegeHours += course.courseHours;
      notifyListeners();
      return;
    }

    if (university.courses
            .where((element) => element.courseCode == course.courseCode)
            ?.isNotEmpty ??
        false) {
      universityHours += course.courseHours;
      notifyListeners();
      return;
    }
  }
}
