import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elgam3a/models/user_model.dart';
import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/error_pop_up.dart';
import 'package:elgam3a/widgets/pick_photo_pop_up.dart';
import 'package:elgam3a/widgets/text_data_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  bool _emailSent = false;
  String _uploadedFileURL;
  String _imagePath;
  String _name;
  String _phoneNumber;
  File _image;

  @override
  void initState() {
    super.initState();
    Future.wait([context.read<AuthProvider>().getUserData()]);
    UserModel user = context.read<AuthProvider>().user;
    user.imageUrl?.isNotEmpty ?? false
        ? _uploadedFileURL = user.imageUrl
        : _uploadedFileURL = '';
    user.imagePath?.isNotEmpty ?? false
        ? _imagePath = user.imagePath
        : _imagePath = '';
  }

  _chooseImageSource() {
    showDialog(
      context: context,
      builder: (BuildContext context) => PickPhotoPopUp(
        pickPhotoOnPressed: () async {
          Navigator.pop(context);
          await _pickImage();
        },
        takePhotoOnPressed: () async {
          Navigator.pop(context);
          await _takeImage();
        },
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final pFile = await ImagePicker().getImage(source: ImageSource.gallery);
      if (pFile != null) {
        _image = (File(pFile.path));
        if (mounted) setState(() {});
      }
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            ErrorPopUp(message: 'Something Went Wrong! please try again'),
      );
    }
  }

  Future<void> _takeImage() async {
    try {
      final pFile = await ImagePicker().getImage(source: ImageSource.camera);
      if (pFile != null) _image = (File(pFile.path));
      if (mounted) setState(() {});
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            ErrorPopUp(message: 'Something Went Wrong! please try again'),
      );
    }
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
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            title: 'Couldn\'t Upload your file', message: '${e.message}'),
      );
    } catch (e, s) {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            ErrorPopUp(message: 'Something Went Wrong! please try again'),
      );
      print(e);
      print(s);
    }
  }

  Future<void> _update() async {
    final provider = context.read<AuthProvider>();
    if (!_formKey.currentState.validate()) {
      setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    if (_name == provider.user.name &&
        _phoneNumber == provider.user.phoneNumber &&
        _image == null) {
      Navigator.pop(context);
      return;
    }
    try {
      LoadingScreen.show(context);
      if (_image != null) {
        if (provider.user.imagePath?.isNotEmpty ?? false) {
          await context.read<AuthProvider>().deleteImage(_imagePath);
          _imagePath = '';
        }
        await uploadFile(context);
      }
      if (_uploadedFileURL.isEmpty || _uploadedFileURL == null) {
        if (_imagePath.isNotEmpty) {
          await context.read<AuthProvider>().deleteImage(_imagePath);
        }

        _imagePath = '';
        provider.user = provider.user.copyWith(imagePath: '', imageUrl: '');
        setState(() {});
      }
      provider.user = provider.user.copyWith(
        name: _name,
        phoneNumber: _phoneNumber,
        imageUrl: _uploadedFileURL,
        imagePath: _imagePath,
      );
      await context.read<AuthProvider>().updateUserData(provider.user);
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e, s) {
      print('crash');
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            ErrorPopUp(message: 'Something Went Wrong! please try again'),
      );
      print('error $e');
      print('trace $s');
    }
  }

  _changePassword() async {
    try {
      final user = context.read<AuthProvider>().user;
      await context.read<AuthProvider>().forgetPassword(user.email);
      _emailSent = true;
      setState(() {});
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit your data',
          style: Theme.of(context)
              .appBarTheme
              .textTheme
              .headline1
              .copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_image == null) ...{
                      //when he pick no image
                      // so its is if there is image from network or not
                      if (_uploadedFileURL?.isNotEmpty ?? false) ...{
                        GestureDetector(
                          onTap: () {
                            //image url deleted from list in provider
                            // TODO what will happen if the user dont wanna edit !
                            _uploadedFileURL = '';

                            setState(() {});
                          },
                          child: Container(
                            height: 112,
                            width: 112,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color(0xffffffff),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x1a000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: '$_uploadedFileURL',
                                    height: 112,
                                    width: 112,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        LoadingWidget(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                FaIcon(
                                  FontAwesomeIcons.solidTimesCircle,
                                  color: Color(0xFFe04f5f),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      }
                      // no image detected
                      else ...{
                        GestureDetector(
                          onTap: _chooseImageSource,
                          child: Container(
                            height: 112,
                            width: 112,
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
                            child: user.type.toLowerCase() == 'student'
                                ? Image.asset(
                                    'assets/images/student.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/doctor.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      },
                    }
                    // image from device
                    else ...{
                      GestureDetector(
                        onTap: () => removeImage(),
                        child: Container(
                          // padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x1a000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                  height: 112,
                                  width: 112,
                                ),
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidTimesCircle,
                                color: Color(0xFFe04f5f),
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    },
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
                            RequiredRule(
                                validationMessage: 'Name is required.'),
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
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: _changePassword,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  'Change password',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
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
                    child: InkWell(
                      onTap: () => _update(),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF000000).withOpacity(0.34),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Text(
                          'Update',
                          style: Theme.of(context).textTheme.button.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).errorColor,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF000000).withOpacity(0.34),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Text(
                          'Cancel',
                          style: Theme.of(context).textTheme.button.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
