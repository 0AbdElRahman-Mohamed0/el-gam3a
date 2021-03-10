import 'package:elgam3a/models/department_model.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class DepartmentProvider with ChangeNotifier {
  DepartmentModel department;
  DepartmentProvider(this.department);
}
