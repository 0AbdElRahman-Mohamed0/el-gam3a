import 'package:elgam3a/models/course_model.dart';
import 'package:elgam3a/models/department_model.dart';
import 'package:elgam3a/models/user_model.dart';
import 'package:elgam3a/services/api.dart';
import 'package:flutter/material.dart';

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
            tmp.courseDoctor = user.name;
            tmp.courseDay = course.courseDay;
            tmp.courseTime = course.courseTime;
            tmp.courseHall = course.courseHall;
            tmp.courseLocation = course.courseLocation;
            tmp.courseBuilding = course.courseBuilding;
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
            tmp.courseDoctor = user.name;
            tmp.courseDay = course.courseDay;
            tmp.courseTime = course.courseTime;
            tmp.courseHall = course.courseHall;
            tmp.courseLocation = course.courseLocation;
            tmp.courseBuilding = course.courseBuilding;
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
          tmp.courseDoctor = user.name;
          tmp.courseDay = course.courseDay;
          tmp.courseTime = course.courseTime;
          tmp.courseHall = course.courseHall;
          tmp.courseLocation = course.courseLocation;
          tmp.courseBuilding = course.courseBuilding;
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
          tmp.courseDoctor = user.name;
          tmp.courseDay = course.courseDay;
          tmp.courseTime = course.courseTime;
          tmp.courseHall = course.courseHall;
          tmp.courseLocation = course.courseLocation;
          tmp.courseBuilding = course.courseBuilding;
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

  Future<void> removeProfFromCourse(CourseModel course) async {
    if (majorDepartment != null) {
      if (majorDepartment.courses
              .where((element) => element.courseCode == course.courseCode)
              ?.isNotEmpty ??
          false) {
        final tmp = majorDepartment.courses
            .firstWhere((element) => element.courseCode == course.courseCode);
        tmp.courseDoctor = null;
        majorDepartment.courses
            .removeWhere((e) => e.courseCode == course.courseCode);
        majorDepartment.courses.add(tmp);

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
        tmp.courseDoctor = null;
        minorDepartment.courses
            .removeWhere((e) => e.courseCode == course.courseCode);
        minorDepartment.courses.add(tmp);

        await updateEachCourse(tmp, minorDepartment);
      }
    }

    if (college.courses
        .where((element) => element.courseCode == course.courseCode)
        .isNotEmpty) {
      final tmp = college.courses
          .firstWhere((element) => element.courseCode == course.courseCode);
      tmp.courseDoctor = null;
      college.courses.removeWhere((e) => e.courseCode == course.courseCode);
      college.courses.add(tmp);

      await updateEachCourse(tmp, college);
    }

    if (university.courses
            .where((element) => element.courseCode == course.courseCode)
            ?.isNotEmpty ??
        false) {
      final tmp = university.courses
          .firstWhere((element) => element.courseCode == course.courseCode);
      tmp.courseDoctor = null;
      university.courses.removeWhere((e) => e.courseCode == course.courseCode);
      university.courses.add(tmp);

      await updateEachCourse(tmp, university);
    }
    notifyListeners();
  }

  updateDepHours({CourseModel course, UserModel user, int type}) async {
    if (type == 0 &&
        user.courses
            .where((element) => element.courseCode == course.courseCode)
            .isNotEmpty) {
      return;
    }
    if (majorDepartment != null) {
      if (majorDepartment.courses
              .where((element) => element.courseCode == course.courseCode)
              ?.isNotEmpty ??
          false) {
        type == 0
            ? majorDepartmentHours += course.courseHours
            : majorDepartmentHours -= course.courseHours;
        notifyListeners();
        return;
      }
    }

    if (minorDepartment != null) {
      if (minorDepartment.courses
              .where((element) => element.courseCode == course.courseCode)
              ?.isNotEmpty ??
          false) {
        type == 0
            ? minorDepartmentHours += course.courseHours
            : minorDepartmentHours -= course.courseHours;
        notifyListeners();
        return;
      }
    }

    if (college.courses
        .where((element) => element.courseCode == course.courseCode)
        .isNotEmpty) {
      type == 0
          ? collegeHours += course.courseHours
          : collegeHours -= course.courseHours;
      notifyListeners();
      return;
    }

    if (university.courses
            .where((element) => element.courseCode == course.courseCode)
            ?.isNotEmpty ??
        false) {
      type == 0
          ? universityHours += course.courseHours
          : universityHours -= course.courseHours;
      notifyListeners();
      return;
    }
  }

  getUserDepHours(UserModel user) async {
    if (user.courses != null) {
      if (user.courses.isEmpty) return;
    }
    if (user.courses == null) {
      return;
    }
    for (CourseModel course in user.courses) {
      if (majorDepartment != null) {
        if (majorDepartment.courses
                .where((element) => element.courseCode == course.courseCode)
                ?.isNotEmpty ??
            false) {
          final tmp = majorDepartment.courses
              .where((element) => element.courseCode == course.courseCode);
          for (CourseModel course in tmp) {
            majorDepartmentHours += course.courseHours;
          }
        }
      }

      if (minorDepartment != null) {
        if (minorDepartment.courses
                .where((element) => element.courseCode == course.courseCode)
                ?.isNotEmpty ??
            false) {
          final tmp = minorDepartment.courses
              .where((element) => element.courseCode == course.courseCode);
          for (CourseModel course in tmp) {
            minorDepartmentHours += course.courseHours;
          }
        }
      }

      if (college.courses
          .where((element) => element.courseCode == course.courseCode)
          .isNotEmpty) {
        final tmp = college.courses
            .where((element) => element.courseCode == course.courseCode);
        for (CourseModel course in tmp) {
          collegeHours += course.courseHours;
        }
      }

      if (university.courses
              .where((element) => element.courseCode == course.courseCode)
              ?.isNotEmpty ??
          false) {
        final tmp = university.courses
            .where((element) => element.courseCode == course.courseCode);
        for (CourseModel course in tmp) {
          universityHours += course.courseHours;
        }
      }
    }
    notifyListeners();
  }
}
