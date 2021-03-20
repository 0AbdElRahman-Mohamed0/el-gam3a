import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a/models/course_data_model.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/text_data_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as Path;
import 'package:rflutter_alert/rflutter_alert.dart';

class AddCourseDataScreen extends StatefulWidget {
  final String title;
  AddCourseDataScreen({this.title});

  @override
  _AddCourseDataScreenState createState() => _AddCourseDataScreenState();
}

class _AddCourseDataScreenState extends State<AddCourseDataScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _pdfNull = false;
  File _pdf;
  String _name;
  String _number;
  String _uploadedFileURL;
  bool isLoading = true;

  final firestore = FirebaseFirestore.instance;

  Future<void> _pickFile() async {
    final File pFile = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pFile != null) {
      if (mounted)
        setState(() {
          _pdf = File(pFile.path);
        });
    }
  }

  Future<void> uploadFile(BuildContext context) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(_pdfFolderPath);
      await ref.putFile(_pdf);
      await ref.getDownloadURL().then((fileURL) {
        _uploadedFileURL = fileURL;
        if (mounted) setState(() {});
      });
    } on FirebaseException catch (e) {
      Alert(
        context: context,
        title: 'Couldn\'t Upload your file',
        desc: e.message,
      ).show();
    } catch (e) {
      Alert(
        context: context,
        title: 'Couldn\'t Upload your file, Please try again.',
      ).show();
    }
  }

  String get _pdfFolderPath => "coursePDF"
      "/${Path.basename(_pdf.path)}";

  Future<void> _submitLecture() async {
    final provider = context.read<CourseProvider>();
    final course = provider.course;
    if (!_formKey.currentState.validate() || _pdf == null) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      if (!_pdfNull) setState(() => _pdfNull = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      await uploadFile(context);
      final lecture = CourseDataModel(
        name: _name,
        number: _number,
        time: DateTime.now(),
        pdfPath: _pdf.path,
        pdfUrl: _uploadedFileURL,
      );
      final response = await firestore
          .collection('each_course_data')
          .where('courseCode', isEqualTo: course.courseCode)
          .get();
      final DocumentReference data = await firestore
          .collection('each_course_data')
          .doc(response.docs.first.id)
          .collection('lectures')
          .add(lecture.toMap());
      await firestore
          .collection('each_course_data')
          .doc(response.docs.first.id)
          .update({'updated_at': DateTime.now()});
      await firestore
          .collection('each_course_data')
          .doc(response.docs.first.id)
          .collection('lectures')
          .doc(data.id)
          .update({'id': data.id});
      provider.addLecture(lecture);
      Navigator.pop(context);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print('$e');
      Navigator.pop(context);
    } catch (e) {
      print('$e');
      Navigator.pop(context);
    }
  }

  Future<void> _submitQuiz() async {
    final provider = context.read<CourseProvider>();
    final course = provider.course;
    if (!_formKey.currentState.validate() || _pdf == null) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      if (!_pdfNull) setState(() => _pdfNull = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      await uploadFile(context);
      final quiz = CourseDataModel(
        name: _name,
        number: _number,
        time: DateTime.now(),
        pdfPath: _pdf.path,
        pdfUrl: _uploadedFileURL,
      );
      final response = await firestore
          .collection('each_course_data')
          .where('courseCode', isEqualTo: course.courseCode)
          .get();
      final DocumentReference data = await firestore
          .collection('each_course_data')
          .doc(response.docs.first.id)
          .collection('quizzes')
          .add(quiz.toMap());
      await firestore
          .collection('each_course_data')
          .doc(response.docs.first.id)
          .update({'updated_at': DateTime.now()});
      await firestore
          .collection('each_course_data')
          .doc(response.docs.first.id)
          .collection('quizzes')
          .doc(data.id)
          .update({'id': data.id});
      provider.addQuiz(quiz);
      Navigator.pop(context);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print('$e');
      Navigator.pop(context);
    } catch (e) {
      print('$e');
      Navigator.pop(context);
    }
  }

  Future<void> _submitSheet() async {
    final provider = context.read<CourseProvider>();
    final course = provider.course;
    if (!_formKey.currentState.validate() || _pdf == null) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      if (!_pdfNull) setState(() => _pdfNull = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      await uploadFile(context);
      final sheet = CourseDataModel(
        name: _name,
        number: _number,
        time: DateTime.now(),
        pdfPath: _pdf.path,
        pdfUrl: _uploadedFileURL,
      );
      final response = await firestore
          .collection('each_course_data')
          .where('courseCode', isEqualTo: course.courseCode)
          .get();
      final DocumentReference data = await firestore
          .collection('each_course_data')
          .doc(response.docs.first.id)
          .collection('sheets')
          .add(sheet.toMap());
      await firestore
          .collection('each_course_data')
          .doc(response.docs.first.id)
          .update({'updated_at': DateTime.now()});
      await firestore
          .collection('each_course_data')
          .doc(response.docs.first.id)
          .collection('sheets')
          .doc(data.id)
          .update({'id': data.id});
      provider.addSheet(sheet);
      Navigator.pop(context);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print('$e');
      Navigator.pop(context);
    } catch (e) {
      print('$e');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.title
        .replaceRange(0, 1, widget.title.substring(0, 1).toUpperCase());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add $type',
          style: Theme.of(context).appBarTheme.textTheme.headline1.copyWith(
                fontSize: 20,
              ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    autovalidateMode: _autoValidate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        TextDataField(
                          labelName: '$type name',
                          onSaved: (name) {
                            _name = name;
                          },
                          validator: Validator(
                            rules: [
                              RequiredRule(
                                  validationMessage:
                                      'Name of ${widget.title} must added'),
                            ],
                          ),
                        ),
                        TextDataField(
                          labelName: '$type number',
                          keyboardType: TextInputType.number,
                          onSaved: (number) {
                            _number = number;
                          },
                          validator: Validator(
                            rules: [
                              RequiredRule(
                                  validationMessage:
                                      'Number of ${widget.title} must added'),
                            ],
                          ),
                        ),
                        _pdf == null
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: _pickFile,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: _pdfNull
                                              ? Theme.of(context).errorColor
                                              : Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      child: Text(
                                        'Add ${widget.title} pdf',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                  ),
                                  if (_pdfNull) ...{
                                    Text(
                                      'You must put ${widget.title} file',
                                      style: TextStyle(
                                        color: Colors.red[700],
                                      ),
                                    ),
                                  },
                                ],
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.filePdf,
                                      color: Theme.of(context).cardColor,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${_pdf.path.characters.toString().split('/data/user/0/com.example.elgam3a/cache/file_picker/')[1]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: widget.title.toLowerCase() == 'lecture'
                        ? _submitLecture
                        : widget.title.toLowerCase() == 'quiz'
                            ? _submitQuiz
                            : _submitSheet,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(18.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.34),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Add ${widget.title}',
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
          ),
        ),
      ),
    );
  }
}
