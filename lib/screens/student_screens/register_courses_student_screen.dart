import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/providers/courses_provider.dart';
import 'package:elgam3a/providers/department_provider.dart';
import 'package:elgam3a/providers/departments_provider.dart';
import 'package:elgam3a/widgets/course_choosed_card.dart';
import 'package:elgam3a/widgets/register_course_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/loading.dart';

class RegisterCoursesStudentScreen extends StatefulWidget {
  @override
  _RegisterCoursesStudentScreenState createState() =>
      _RegisterCoursesStudentScreenState();
}

class _RegisterCoursesStudentScreenState
    extends State<RegisterCoursesStudentScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    _isLoading = true;
    setState(() {});
    final user = context.read<AuthProvider>().user;
    await Future.wait({
      context
          .read<DepartmentsProvider>()
          .getCoursesDataByMajorDepartmentName(user.department),
      context
          .read<DepartmentsProvider>()
          .getCoursesDataByMinorDepartmentName(user.minor),
      context.read<DepartmentsProvider>().getCoursesDataGeneral(),
    });
    context.read<DepartmentsProvider>().getUserDepHours(user);
    _isLoading = false;
    setState(() {});
  }

  _updateCourse() async {
    LoadingScreen.show(context);
    final user = context.read<AuthProvider>().user;
    await Future.wait({
      context.read<DepartmentsProvider>().updateCourse(user),
      context.read<AuthProvider>().updateUserData(user),
    });
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final majorDepartment =
        context.watch<DepartmentsProvider>().majorDepartment;
    final minorDepartment =
        context.watch<DepartmentsProvider>().minorDepartment;
    final college = context.watch<DepartmentsProvider>().college;
    final university = context.watch<DepartmentsProvider>().university;
    final majorHours =
        context.watch<DepartmentsProvider>().majorDepartmentHours;
    final minorHours =
        context.watch<DepartmentsProvider>().minorDepartmentHours;
    final universityHours =
        context.watch<DepartmentsProvider>().universityHours;
    final collegeHours = context.watch<DepartmentsProvider>().collegeHours;
    final user = context.watch<AuthProvider>().user;
    return DefaultTabController(
      length: user.department != null ? 4 : 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Register Courses',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
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
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text('Register'),
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
                            height: (MediaQuery.of(context).size.height * 150) /
                                667,
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
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${user.registeredHours}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              .copyWith(
                                                  //Colors.black,
                                                  fontSize: 48.0,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        TextSpan(
                                          text: '/18',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: (MediaQuery.of(context).size.height * 150) /
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
                                      if (user.department != null &&
                                          user.minor != null) ...{
                                        Text(
                                          'Major',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              .copyWith(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        Text(
                                          'Minor',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              .copyWith(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      },
                                      Text(
                                        'College',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      Text(
                                        'University',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                              fontSize: 14.0,
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
                                                      fontSize: 14.0,
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
                                                      fontSize: 14.0,
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
                                              text: '$minorHours',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(
                                                      fontSize: 14.0,
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
                                                      fontSize: 14.0,
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
                                              text: '$collegeHours',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(
                                                      fontSize: 14.0,
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
                                                      fontSize: 14.0,
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(
                                                      fontSize: 14.0,
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
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w700),
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
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                      tabs: [
                        if (user.department != null && user.minor != null) ...{
                          FittedBox(child: Tab(text: "Major")),
                          FittedBox(child: Tab(text: "Minor")),
                        },
                        FittedBox(child: Tab(text: "College")),
                        FittedBox(child: Tab(text: "University")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        if (user.department != null && user.minor != null) ...{
                          ChangeNotifierProvider<DepartmentProvider>(
                            create: (context) =>
                                DepartmentProvider(majorDepartment),
                            child: RegisterCourseWidget(),
                          ),
                          ChangeNotifierProvider<DepartmentProvider>(
                            create: (context) =>
                                DepartmentProvider(minorDepartment),
                            child: RegisterCourseWidget(),
                          ),
                        },
                        ChangeNotifierProvider<DepartmentProvider>(
                          create: (context) => DepartmentProvider(college),
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
