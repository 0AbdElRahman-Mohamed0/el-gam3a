import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a/services/vars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
}
