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
    this.students,
    this.courseDepartment,
    this.courseBuilding,
  });

  String courseName;
  int courseHours;
  String courseCode;
  String courseDoctor;
  List<String> courseAssistants = [];
  List<String> students = [];
  String courseLocation;
  String courseBuilding;
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
    courseBuilding = m[CourseData.BUILDING];
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
      CourseData.BUILDING: courseBuilding,
      CourseData.DAY: courseDay,
      CourseData.TIME: courseTime,
      CourseData.HALL: courseHall,
      CourseData.DEPARTMENT: courseDepartment,
      CourseData.REQUIRED: isRequired,
      CourseData.SHOW: show,
    };
  }

  CourseModel copyWith({
    String courseName,
    int courseHours,
    String courseCode,
    String courseDoctor,
    List<String> courseAssistants,
    List<String> students,
    String courseLocation,
    String courseDay,
    String courseTime,
    String courseDepartment,
    int courseHall,
    bool isRequired,
    bool show,
    String courseBuilding,
  }) {
    return CourseModel(
      courseName: courseName ?? this.courseName,
      courseHours: courseHours ?? this.courseHours,
      courseCode: courseCode ?? this.courseCode,
      courseDoctor: courseDoctor ?? this.courseDoctor,
      courseAssistants: courseAssistants ?? this.courseAssistants,
      students: students ?? this.students,
      courseLocation: courseLocation ?? this.courseLocation,
      courseDay: courseDay ?? this.courseDay,
      courseTime: courseTime ?? this.courseTime,
      courseDepartment: courseDepartment ?? this.courseDepartment,
      courseHall: courseHall ?? this.courseHall,
      isRequired: isRequired ?? this.isRequired,
      courseBuilding: courseBuilding ?? this.courseBuilding,
      show: show ?? this.show,
    );
  }
}
