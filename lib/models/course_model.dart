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
    this.isRequired,
    this.show,
  });

  String courseName;
  int courseHours;
  String courseCode;
  String courseDoctor;
  List<String> courseAssistants = [];
  List<String> students = [];
  String courseLocation;
  String courseDay;
  String courseTime;
  String courseDepartment;
  int courseHall;
  bool isRequired;
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
    isRequired = m[CourseData.REQUIRED];
    courseDepartment = m[CourseData.DEPARTMENT];
    show = m[CourseData.SHOW];
  }

  Map<String, dynamic> toMap() {
    return {
      CourseData.NAME: courseName,
      CourseData.CODE: courseCode,
      CourseData.DOCTOR: courseDoctor,
      CourseData.CREDIT_HOURS: courseHours,
      CourseData.ASSISTANTS: courseAssistants ?? [],
      CourseData.STUDENTS: students ?? [],
      CourseData.LOCATION: courseLocation,
      CourseData.DAY: courseDay,
      CourseData.TIME: courseTime,
      CourseData.HALL: courseHall,
      CourseData.DEPARTMENT: courseDepartment,
      CourseData.REQUIRED: isRequired,
      CourseData.SHOW: show,
    };
  }
}
