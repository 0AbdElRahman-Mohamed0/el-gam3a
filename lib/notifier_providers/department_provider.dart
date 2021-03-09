import 'package:elgam3a/models/department_model.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class DepartmentNotifierProvider with ChangeNotifier {
  DepartmentModel department;
  DepartmentNotifierProvider(this.department);
}
