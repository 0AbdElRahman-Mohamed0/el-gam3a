import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a/models/user_model.dart';
import 'package:elgam3a/services/api.dart';
import 'package:elgam3a/services/vars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ApiProvider _api = ApiProvider.instance;

  bool get isAuth => uid != null;

  String get uid => auth.currentUser?.uid;

  User get user => auth.currentUser;

  UserModel userModel;

  isSignedIn() {
    return auth.currentUser != null;
  }

  Future<void> forgetPassword(String email) async {
    await _api.forgetPassword(email);
  }

  Future<String> logIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final response =
        await firestore.collection(UserData.USER_DATA_TABLE).doc(uid).get();
    userModel = UserModel.fromMap(response.data());
    notifyListeners();
    return userModel.type;
  }

  Future<String> getEmailOfStudentByUnivID(String univID) async {
    final email = await _api.getEmailOfStudentByUnivID(univID);
    return email;
  }

  Future<String> getUserData() async {
    final response =
        await firestore.collection(UserData.USER_DATA_TABLE).doc(uid).get();
    userModel = UserModel.fromMap(response.data());
    notifyListeners();
    return userModel.type;
  }

  // update user data
  Future<void> updateUserData(UserModel userUpdates) async {
    await firestore
        .collection(UserData.USER_DATA_TABLE)
        .doc(uid)
        .update(userUpdates.toMap());
    userModel = userUpdates;
    notifyListeners();
  }

  bool tryAutoLogin() => isAuth;

  Future<void> logOut() async {
    await auth.signOut();
    userModel = null;

    notifyListeners();
  }

  ///// Delete fireStore image ////////
  Future<void> deleteImage(String imagePath) async {
    await _api.deleteFireBaseStorageImage(imagePath);
  }
}
