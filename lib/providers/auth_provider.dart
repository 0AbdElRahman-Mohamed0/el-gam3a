import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a/models/user_model.dart';
import 'package:elgam3a/services/api.dart';
import 'package:elgam3a/services/vars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/course_model.dart';

export 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ApiProvider _api = ApiProvider.instance;

  bool get isAuth => uid != null;

  String get uid => auth.currentUser?.uid;

  User get currentUser => auth.currentUser;

  UserModel user;
  List<CourseModel> mySchedule = [];

  isSignedIn() {
    return auth.currentUser != null;
  }

  Future<void> forgetPassword(String email) async {
    await _api.forgetPassword(email);
  }

  Future<String> getEmailOfStudentByUnivID(String univID) async {
    return await _api.getEmailOfStudentByUnivID(univID);
  }

  Future<void> logIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    final _response =
        await firestore.collection(UserData.USER_DATA_TABLE).doc(uid).get();
    if (_response.data().isNotEmpty) {
      user = UserModel.fromMap(_response.data());
      notifyListeners();
    } else {
      print('api Error@logIn');
      throw 'error';
    }
  }

  Future<void> getUserData() async {
    final _response =
        await firestore.collection(UserData.USER_DATA_TABLE).doc(uid).get();
    if (_response.data().isNotEmpty) {
      user = UserModel.fromMap(_response.data());
      notifyListeners();
    } else {
      print('api Error@logIn');
      throw 'error';
    }
  }

  // update user data
  Future<void> updateUserData(UserModel userUpdates) async {
    await firestore
        .collection(UserData.USER_DATA_TABLE)
        .doc(uid)
        .update(userUpdates.toMap());
    user = userUpdates;
    notifyListeners();
  }

  bool tryAutoLogin() => isAuth;

  Future<void> logOut() async {
    await auth.signOut();
    user = null;
    notifyListeners();
  }

  ///// Delete fireStore image ////////
  Future<void> deleteImage(String imagePath) async {
    await _api.deleteFireBaseStorageImage(imagePath);
  }

  addCourse(CourseModel course) {
    if (user.courses
        .where((element) => element.courseCode == course.courseCode)
        .isNotEmpty) {
      return;
    }
    user.courses.add(course);
    user.registeredHours =
        (num.parse(user.registeredHours) + course.courseHours).toString();
    notifyListeners();
  }

  removeCourse(CourseModel course) async {
    user.courses.removeWhere((e) => e.courseCode == course.courseCode);
    user.registeredHours =
        (num.parse(user.registeredHours) - course.courseHours).toString();
    final tmp = List.of(user.courses);
    user.courses = null;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 500));
    user.courses = List.of(tmp);
    notifyListeners();
  }

  Future<void> getScheduleCourses(String day) async {
    mySchedule = [];
    if (user.courses.isNotEmpty) {
      mySchedule.addAll(user.courses.where((element) =>
          element.courseDay?.toUpperCase()?.substring(0, 3) == day));
    }
    notifyListeners();
  }
}
