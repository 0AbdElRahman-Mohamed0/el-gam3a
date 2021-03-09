import 'package:elgam3a/services/vars.dart';

class CourseModel {
  CourseModel({
    this.courseName,
    this.courseCode,
    this.courseDoctor,
    this.courseAssistants,
    this.courseLocation,
    this.courseDay,
    this.courseTime,
    this.courseHall,
    this.courseHours,
    this.required,
    this.show,
  });

  String courseName;
  int courseHours;
  String courseCode;
  String courseDoctor;
  List<String> courseAssistants = [];
  String courseLocation;
  String courseDay;
  String courseTime;
  int courseHall;
  bool required;
  bool show;

  CourseModel.fromMap(Map<String, dynamic> m) {
    courseName = m[CourseData.NAME];
    courseHours = m[CourseData.CREDIT_HOURS];
    courseCode = m[CourseData.CODE];
    courseDoctor = m[CourseData.DOCTOR];
    if (m[CourseData.ASSISTANTS] != null)
      m[CourseData.ASSISTANTS].forEach((e) => courseAssistants.add(e));
    courseLocation = m[CourseData.LOCATION];
    courseDay = m[CourseData.DAY];
    courseTime = m[CourseData.TIME];
    courseHall = m[CourseData.HALL];
    required = m[CourseData.REQUIRED];
    show = m[CourseData.SHOW];
  }
}
