import 'dart:io';
import 'dart:math';
import 'package:elgam3a/models/user_model.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:path/path.dart' as Path;

import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/screens/login_screen.dart';
import 'package:elgam3a/widgets/text_data_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  bool edit = false;
  bool _emailSent = false;
  String _uploadedFileURL;
  String _imagePath;
  String _name;
  String _phoneNumber;
  File _image;

  Future<void> pickImage() async {
    final pFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pFile != null) _image = File(pFile.path);
    if (mounted) setState(() {});
  }

  Future<void> takeImage() async {
    final pFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pFile != null) _image = File(pFile.path);
    if (mounted) setState(() {});
  }

  void removeImage() {
    setState(() => _image = null);
  }

  ////////////////////// Upload Image ///////////////////////////////

  String get _imagesFolderPath => "profile_images"
      "/${Path.basename(_image.path)}";

// TODO image url not update after submit .... it has to get from api to update
  Future<void> uploadFile(BuildContext context) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(_imagesFolderPath);
      await ref.putFile(_image);
      await ref.getDownloadURL().then((fileURL) {
        _uploadedFileURL = fileURL;
        _imagePath = _imagesFolderPath;
        if (mounted) setState(() {});
      });
    } on FirebaseException catch (e, s) {
      print(e.code);
      print(s);

      Alert(
        context: context,
        title: 'Couldn\'t Upload your file',
        desc: e.message,
      ).show();
    } catch (e, s) {
      Alert(
        context: context,
        title: 'Couldn\'t Upload your file, Please try again.',
      ).show();

      print(e);
      print(s);
    }
  }

  Future<void> _update() async {
    UserModel user = context.read<AuthProvider>().userModel;
    if (!_formKey.currentState.validate()) {
      setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    if (_name == user.name && _phoneNumber == user.phoneNumber) {
      print('canceled');
      edit = false;
      setState(() {});
      return;
    }
    try {
      // LoadingScreen.show(context);

      // //pick a new image
      // if (_image != null) {
      //   //if he picked image before and change it
      //   if (user.imagePath?.isNotEmpty ?? false) {
      //     print('image path before $_imagePath');
      //     await context.read<AuthProvider>().deleteImage(_imagePath);
      //     print('image path after $_imagePath');
      //
      //     _imagePath = '';
      //   }
      //   await uploadFile(context);
      // }
      // when he delete the image and not want to add a new one
      // if (_uploadedFileURL.isEmpty || _uploadedFileURL == null) {
      //   if (_imagePath.isNotEmpty) {
      //     await context.read<AuthProvider>().deleteImage(_imagePath);
      //   }
      //
      //   _imagePath = '';
      //   user = user.copyWith(imagePath: '', imageUrl: '');
      //   setState(() {});
      // }
      user = user.copyWith(
        name: _name,
        phoneNumber: _phoneNumber,
        imageUrl: _uploadedFileURL,
        imagePath: _imagePath,
      );
      edit = false;
      await context.read<AuthProvider>().updateUserData(user);
      // Navigator.pop(context);
    } catch (e, s) {
      print('crash');
      // Navigator.pop(context);
      Alert(context: context, title: 'something went wrong! please try again')
          .show();
      print('error $e');
      print('trace $s');
    }
  }

  _changePassword() async {
    try {
      final user = context.read<AuthProvider>().userModel;
      await context.read<AuthProvider>().forgetPassword(user.email);
      _emailSent = true;
      setState(() {});
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  _logout() {
    context.read<AuthProvider>().logOut();
    pushNewScreen(
      context,
      screen: LoginScreen(),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().userModel;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: edit
          ? editData()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 112,
                          width: 112,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                offset: Offset(0, 3),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Image.asset('assets/images/student.png'),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.name}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${user.type}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RaisedButton(
                                color: Theme.of(context).buttonColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onPressed: () {
                                  edit = true;
                                  setState(() {});
                                },
                                child: Text('Edit Data'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserData(
                          dataTitle: 'ID',
                          dataValue: '${user.univID}',
                        ),
                        UserData(
                          dataTitle: 'Email',
                          dataValue: '${user.email}',
                        ),
                        UserData(
                          dataTitle: 'Phone Number',
                          dataValue: '${user.phoneNumber}',
                        ),
                        user.department == null
                            ? UserData(
                                dataTitle: 'Department',
                                dataValue: '${user.department} / ${user.minor}',
                              )
                            : SizedBox(),
                        UserData(
                          dataTitle: 'GPA',
                          dataValue: '${user.gpa} / 4.0',
                        ),
                        UserData(
                          dataTitle: 'Hours',
                          dataValue: '${user.completedHours} / 132',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).errorColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onPressed: () => _logout(),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget editData() {
    final user = context.watch<AuthProvider>().userModel;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 112,
                    width: 112,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          offset: Offset(0, 3),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/student.png'),
                  ),
                ],
              ),
              SizedBox(
                height: 34,
              ),
              Form(
                key: _formKey,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextDataField(
                      labelName: 'Name',
                      initialValue: '${user.name}',
                      onSaved: (name) {
                        _name = name ?? user.name;
                      },
                      validator: Validator(
                        rules: [
                          RequiredRule(validationMessage: 'Name is required.'),
                        ],
                      ),
                    ),
                    TextDataField(
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                      labelName: 'Phone Number',
                      initialValue: '${user.phoneNumber}',
                      onSaved: (phoneNumber) {
                        _phoneNumber = phoneNumber ?? user.phoneNumber;
                      },
                      validator: Validator(
                        rules: [
                          RequiredRule(
                              validationMessage: 'Phone number is required.'),
                          MinLengthRule(11,
                              validationMessage:
                                  'Phone number must have 11 number.'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _emailSent
                        ? Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.green[300],
                                size: 28,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Reset email sent, please check your mail.',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          )
                        : FlatButton(
                            onPressed: () => _changePassword(),
                            child: Text('Change password'),
                          ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 44,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: RaisedButton(
                    color: Colors.green[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onPressed: () => _update(),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    color: Theme.of(context).errorColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onPressed: () {
                      edit = false;
                      setState(() {});
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserData extends StatelessWidget {
  UserData({this.dataTitle, this.dataValue});
  final String dataTitle;
  final String dataValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Text(
                '$dataTitle : ',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontFamily: 'SF Mono',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Expanded(
                child: Text(
                  '$dataValue',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
