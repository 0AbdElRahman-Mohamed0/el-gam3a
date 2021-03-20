import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a/models/course_data_model.dart';
import 'package:elgam3a/models/course_model.dart';
import 'package:elgam3a/models/department_model.dart';
import 'package:elgam3a/models/faculty_model.dart';
import 'package:elgam3a/models/hall_model.dart';
import 'package:elgam3a/services/vars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class ApiProvider {
  ApiProvider._();

  static final ApiProvider instance = ApiProvider._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  // Get Email
  Future getEmailOfStudentByUnivID(String univID) async {
    final _response = await firestore
        .collection(UserData.USER_DATA_TABLE)
        .where(UserData.UNIV_ID, isEqualTo: univID)
        .get();
    if (_response.docs.isNotEmpty) {
      final email = _response.docs.first.data()['email'];
      print('emaiiiiiiil $email');
      return email;
    } else {
      print('api Error@getEmailOfStudentByUnivID');
      // Err
      throw _response.docs;
    }
  }

  // forget password
  Future<void> forgetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  // delete image from firebase storage
  Future<void> deleteFireBaseStorageImage(String filePath) async {
    await FirebaseStorage.instance.ref().child(filePath).delete().whenComplete(
        () => print('Successfully deleted $filePath storage item'));
  }

  Future<DepartmentModel> getCoursesDataByDepartmentName(
      String departmentName) async {
    final _response = await firestore
        .collection(DepartmentData.DEPARTMENT_TABLE)
//        .where(DepartmentData.NAME, isEqualTo: departmentName)
        .get()
        .then((QuerySnapshot value) => value.docs.firstWhere(
            (element) => element[DepartmentData.NAME] == departmentName));

    DepartmentModel department;
    if (_response.exists) {
      department = DepartmentModel.fromMap(_response.data());
      return department;
    } else {
      print('api Error@getCoursesDataByDepartmentName');
      // Err
      throw department;
    }
  }

  Future<void> updateCourse(
      List<CourseModel> courses, String departmentID) async {
    await firestore
        .collection(DepartmentData.DEPARTMENT_TABLE)
        .doc(departmentID)
        .update({
      DepartmentData.COURSES: courses.map((course) => course.toMap()).toList(),
    });
  }

  Future<List<FacultyModel>> getFaculties() async {
    final _response =
        await firestore.collection(FacultyData.FACULTY_TABLE).get();
    if (_response.docs.isNotEmpty) {
      final List<FacultyModel> _faculties = [];
      _response.docs.forEach((element) {
        _faculties.add(FacultyModel.fromMap(element.data()));
      });
      return _faculties;
    } else {
      print('api Error@getFaculties');
      // Err
      throw _response.docs;
    }
  }

  Future<List<CourseDataModel>> getLectures(CourseModel course) async {
    final _response = await firestore
        .collection('each_course_data')
        .where('courseCode', isEqualTo: course.courseCode)
        .get();

    final _data = await firestore
        .collection('each_course_data')
        .doc(_response.docs.first.id)
        .collection('lectures')
        .get();
    if (_data.docs.isNotEmpty) {
      final List<CourseDataModel> _lectures = [];
      _data.docs.forEach((element) {
        _lectures.add(CourseDataModel.fromMap(element.data()));
      });
      return _lectures;
    } else {
      print('api Error@getLectures');
      // Err
      throw _response.docs;
    }
  }

  Future<List<CourseDataModel>> getQuizzes(CourseModel course) async {
    final _response = await firestore
        .collection('each_course_data')
        .where('courseCode', isEqualTo: course.courseCode)
        .get();

    final _data = await firestore
        .collection('each_course_data')
        .doc(_response.docs.first.id)
        .collection('quizzes')
        .get();
    if (_data.docs.isNotEmpty) {
      final List<CourseDataModel> _quizzes = [];
      _data.docs.forEach((element) {
        _quizzes.add(CourseDataModel.fromMap(element.data()));
      });
      return _quizzes;
    } else {
      print('api Error@getQuizzes');
      // Err
      throw _response.docs;
    }
  }

  Future<List<CourseDataModel>> getSheets(CourseModel course) async {
    final _response = await firestore
        .collection('each_course_data')
        .where('courseCode', isEqualTo: course.courseCode)
        .get();

    final _data = await firestore
        .collection('each_course_data')
        .doc(_response.docs.first.id)
        .collection('sheets')
        .get();
    if (_data.docs.isNotEmpty) {
      final List<CourseDataModel> _sheets = [];
      _data.docs.forEach((element) {
        _sheets.add(CourseDataModel.fromMap(element.data()));
      });
      return _sheets;
    } else {
      print('api Error@getSheets');
      // Err
      throw _response.docs;
    }
  }

  Future<void> updateHall(List<HallModel> halls, String facultyID) async {
    await firestore
        .collection(FacultyData.FACULTY_TABLE)
        .doc(facultyID)
        .update({
      FacultyData.HALLS: halls.map((hall) => hall.toMap()).toList(),
    });
  }

  Future<void> addCourseGeneral(CourseModel course) async {
    await firestore
        .collection('course_data')
        .doc(course.courseCode)
        .set(course.toMap());
  }

  Future<void> removeCourseGeneral(CourseModel course) async {
    await firestore.collection('course_data').doc(course.courseCode).delete();
  }

  Future<List<CourseModel>> getCourseGeneral() async {
    final _response = await firestore.collection('course_data').get();
    if (_response.docs.isNotEmpty) {
      final List<CourseModel> _courses = [];
      _response.docs.forEach((element) {
        _courses.add(CourseModel.fromMap(element.data()));
      });
      return _courses;
    } else {
      print('api Error@getCourseGeneral');
      // Err
      throw _response.docs;
    }
  }

  Future<void> downloadPDF(String url, String name) async {
    await FlutterDownloader.enqueue(
      fileName: '$name.pdf',
      url: '$url',
      savedDir: '/storage/emulated/0/Download',
      showNotification: true,
      openFileFromNotification: true,
    );
  }
}
