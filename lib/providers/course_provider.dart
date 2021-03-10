import 'package:elgam3a/models/course_model.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class CourseProvider with ChangeNotifier {
  CourseModel course;
  CourseProvider(this.course);
}
