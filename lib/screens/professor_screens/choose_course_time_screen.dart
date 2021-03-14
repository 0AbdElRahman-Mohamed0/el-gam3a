import 'package:elgam3a/models/day_model.dart';
import 'package:elgam3a/models/faculty_model.dart';
import 'package:elgam3a/models/hall_model.dart';
import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/providers/departments_provider.dart';
import 'package:elgam3a/providers/faculties_provider.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/drop_down.dart';
import 'package:flutter/material.dart';

class ChooseCourseTimeScreen extends StatefulWidget {
  @override
  _ChooseCourseTimeScreenState createState() => _ChooseCourseTimeScreenState();
}

class _ChooseCourseTimeScreenState extends State<ChooseCourseTimeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  FacultyModel _faculty;
  HallModel _hall;
  DayModel _day;
  String _time;

  _submit() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();

    LoadingScreen.show(context);
    final provider = context.read<CourseProvider>();
    final user = context.read<AuthProvider>().user;
    provider.course = provider.course.copyWith(
      courseDay: _day.name,
      courseTime: _time,
      courseHall: _hall.id,
      courseLocation: _faculty.name,
      courseBuilding: _hall.building,
      courseDoctor: user.name,
    );
    context
        .read<DepartmentsProvider>()
        .updateDepHours(course: provider.course, user: user, type: 0);
    context.read<AuthProvider>().addCourse(provider.course);
    await context.read<FacultiesProvider>().updateHallTimes(
        time: _time, hall: _hall, faculty: _faculty, day: _day);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final faculties = context.watch<FacultiesProvider>().faculties;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Course Details',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DropDown<FacultyModel>(
                    needSpace: false,
                    labelText: 'Faculty',
                    hintText: 'Select faculty',
                    onChanged: (value) {
                      _faculty = value;
                      setState(() {});
                    },
                    list: faculties,
                    onSaved: (value) {
                      _faculty = value;
                    },
                    validator: (v) =>
                        v == null ? 'You must choose faculty.' : null,
                  ),
                  if (_faculty != null) ...{
                    SizedBox(
                      height: 24,
                    ),
                    DropDown<HallModel>(
                      needSpace: false,
                      labelText: 'Hall',
                      hintText: 'Select Hall',
                      onChanged: (value) {
                        _hall = value;
                        setState(() {});
                      },
                      list: _faculty.halls,
                      onSaved: (value) {
                        _hall = value;
                      },
                      validator: (v) =>
                          v == null ? 'You must choose hall.' : null,
                    ),
                  },
                  if (_hall != null) ...{
                    SizedBox(
                      height: 24,
                    ),
                    DropDown<DayModel>(
                      needSpace: false,
                      labelText: 'Day',
                      hintText: 'Select day',
                      onChanged: (value) {
                        _day = value;
                        setState(() {});
                      },
                      list: _hall.days,
                      onSaved: (value) {
                        _day = value;
                      },
                      validator: (v) =>
                          v == null ? 'You must choose day.' : null,
                    ),
                  },
                  if (_day != null) ...{
                    SizedBox(
                      height: 24,
                    ),
                    DropDown<String>(
                      needSpace: false,
                      labelText: 'Time',
                      hintText: 'Select Time',
                      onChanged: (value) {},
                      list: _day.times,
                      onSaved: (value) {
                        _time = value;
                      },
                      validator: (v) =>
                          v == null ? 'You must choose time.' : null,
                    ),
                  },
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
              GestureDetector(
                onTap: _submit,
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
