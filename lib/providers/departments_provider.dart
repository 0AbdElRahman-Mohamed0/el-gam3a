import 'package:elgam3a/models/department_model.dart';
import 'package:elgam3a/services/api.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class DepartmentsProvider with ChangeNotifier {
  final ApiProvider _api = ApiProvider.instance;
  DepartmentModel majorDepartment;
  DepartmentModel minorDepartment;
  DepartmentModel university;
  DepartmentModel college;

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
}
