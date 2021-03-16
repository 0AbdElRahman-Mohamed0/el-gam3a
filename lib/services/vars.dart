abstract class UserData {
  static const String USER_DATA_TABLE = "user_data";
  static const String NAME = "name";
  static const String ID = "userID";
  static const String GPA = "gpa";
  static const String COMPLETED_HOURS = "completed_hours";
  static const String REGISTERED_HOURS = "registered_hours";
  static const String MAJOR = "department";
  static const String DIVISION = "division";
  static const String MINOR = "minor";
  static const String EMAIL = "email";
  static const String TYPE = "type";
  static const String PHONE_NUMBER = 'phone_number';
  static const String UNIV_ID = 'univ_ID';
  static const String IMAGE_URL = 'image';
  static const String IMAGE_PATH = 'imagePath';
  static const String COURSES = 'courses';
}

abstract class DepartmentData {
  static const String DEPARTMENT_TABLE = "departments_data";
  static const String COURSES = "courses";
  static const String ID = "id";
  static const String NAME = "name";
}

abstract class CourseData {
  static const String ASSISTANTS = "assistants";
  static const String STUDENTS = "students";
  static const String CODE = "code";
  static const String CREDIT_HOURS = "credit_hours";
  static const String DAY = "day";
  static const String DEPARTMENT = "department";
  static const String DOCTOR = "doctor";
  static const String BUILDING = "building";
  static const String HALL = "hall";
  static const String LOCATION = "location";
  static const String NAME = "name";
  static const String REQUIRED = "required";
  static const String SHOW = "show";
  static const String TIME = "time";
}

abstract class HallData {
  static const String ID = "id";
  static const String DAYS = "days";
  static const String CAPACITY = "capacity";
  static const String BUILDING = "building";
}

abstract class FacultyData {
  static const String FACULTY_TABLE = "faculties_data";
  static const String ID = "id";
  static const String NAME = "name";
  static const String HALLS = "halls";
}
