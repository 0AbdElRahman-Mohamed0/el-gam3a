import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/providers/courses_provider.dart';
import 'package:elgam3a/providers/department_provider.dart';
import 'package:elgam3a/providers/departments_provider.dart';
import 'package:elgam3a/providers/faculties_provider.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/course_choosed_card.dart';
import 'package:elgam3a/widgets/register_course_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterCoursesDoctorScreen extends StatefulWidget {
  @override
  _RegisterCoursesDoctorScreenState createState() =>
      _RegisterCoursesDoctorScreenState();
}

class _RegisterCoursesDoctorScreenState
    extends State<RegisterCoursesDoctorScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    try {
      _isLoading = true;
      setState(() {});
      final user = context.read<AuthProvider>().user;
      await Future.wait({
        context
            .read<DepartmentsProvider>()
            .getCoursesDataByMajorDepartmentName(user.department),
        context.read<DepartmentsProvider>().getCoursesDataGeneral(),
      });
      context.read<DepartmentsProvider>().getUserDepHours(user);
      _isLoading = false;
      setState(() {});
    } on FirebaseException catch (e) {
      _isLoading = false;
      setState(() {});
      if (e.code == 'network-request-failed') {
        print(' error ${e.code}');
        Alert(
          context: context,
          title: 'Please check your internet connection!',
          style: AlertStyle(
            alertElevation: 0,
          ),
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ).show();
      } else {
        Alert(
          context: context,
          title: '${e.message}',
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
    } catch (e) {
      _isLoading = false;
      setState(() {});
      Alert(
        context: context,
        title: 'Something wrong happened, please try again',
        buttons: [
          DialogButton(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).cardColor
                ]),
            child: Text(
              'Okay',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
  }

  _updateCourse() async {
    try {
      LoadingScreen.show(context);
      final user = context.read<AuthProvider>().user;
      await Future.wait({
        context.read<DepartmentsProvider>().updateCourse(user),
        context.read<AuthProvider>().updateUserData(user),
      });
      Navigator.pop(context);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      if (e.code == 'network-request-failed') {
        print(' error ${e.code}');
        Alert(
          context: context,
          title: 'Please check your internet connection!',
          style: AlertStyle(
            alertElevation: 0,
          ),
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ).show();
      } else {
        Alert(
          context: context,
          title: '${e.message}',
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
    } catch (e) {
      Navigator.pop(context);
      Alert(
        context: context,
        title: 'Something wrong happened, please try again',
        buttons: [
          DialogButton(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).cardColor
                ]),
            child: Text(
              'Okay',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final majorDepartment =
        context.watch<DepartmentsProvider>().majorDepartment;
    final university = context.watch<DepartmentsProvider>().university;
    final universityHours =
        context.watch<DepartmentsProvider>().universityHours;
    final majorHours =
        context.watch<DepartmentsProvider>().majorDepartmentHours;
    final user = context.watch<AuthProvider>().user;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Register Courses',
            style: Theme.of(context)
                .appBarTheme
                .textTheme
                .headline1
                .copyWith(fontSize: 20),
          ),
          actions: [
            if (user.courses?.isNotEmpty ?? false) ...{
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _updateCourse,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).cardColor
                            ]),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.16),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          )
                        ]),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      'Register',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            },
          ],
        ),
        body: _isLoading
            ? Center(
                child: LoadingWidget(),
              )
            : Column(
                children: [
                  user.courses == null
                      ? LoadingWidget(size: 80)
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Container(
                            height: 30,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              children: user.courses
                                  .map(
                                    (course) =>
                                        ChangeNotifierProvider<CourseProvider>(
                                      create: (_) => CourseProvider(course),
                                      child: CourseChoosedCard(),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
//                            height: (MediaQuery.of(context).size.height * 100) /
//                                667,
                            margin: EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .dividerColor
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0, left: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'hours Registered',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '${user.registeredHours}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .copyWith(
                                            fontSize: 50.0,
                                            fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: (MediaQuery.of(context).size.height * 100) /
                                667,
                            margin: EdgeInsets.only(left: 8.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 12.0,
                                  right: (MediaQuery.of(context).size.width *
                                          34.0) /
                                      375),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Department',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      Text(
                                        'University',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '$majorHours',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            TextSpan(
                                              text: '/${user.registeredHours}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .button
                                                          .color
                                                          .withOpacity(0.5),
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '$universityHours',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            TextSpan(
                                              text: '/${user.registeredHours}',
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TabBar(
                      physics: NeverScrollableScrollPhysics(),
                      labelPadding: EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      indicator: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      labelColor: Theme.of(context).scaffoldBackgroundColor,
                      unselectedLabelColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                      labelStyle: Theme.of(context).textTheme.button.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                      tabs: [
                        FittedBox(child: Tab(text: "Department")),
                        FittedBox(child: Tab(text: "University")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        ChangeNotifierProvider<DepartmentProvider>(
                          create: (context) =>
                              DepartmentProvider(majorDepartment),
                          child: RegisterCourseWidget(),
                        ),
                        ChangeNotifierProvider<DepartmentProvider>(
                          create: (context) => DepartmentProvider(university),
                          child: RegisterCourseWidget(),
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
