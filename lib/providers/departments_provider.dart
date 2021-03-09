import 'package:elgam3a/models/department_model.dart';
import 'package:elgam3a/services/api.dart';
import 'package:flutter/material.dart';

class DepartmentsProvider with ChangeNotifier {
  final ApiProvider _api = ApiProvider.instance;
  DepartmentModel majorDepartment;
  DepartmentModel minorDepartment;

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
}
