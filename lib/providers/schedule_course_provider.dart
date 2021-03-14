import 'package:elgam3a/models/course_model.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class ScheduleCourseProvider with ChangeNotifier {
  CourseModel course;
  ScheduleCourseProvider(this.course);
}
