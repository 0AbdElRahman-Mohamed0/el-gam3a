import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/department_provider.dart';
import 'package:elgam3a/providers/departments_provider.dart';
import 'package:elgam3a/widgets/register_course_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/loading.dart';

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
    _isLoading = true;
    setState(() {});
    final user = context.read<AuthProvider>().user;
    await context
        .read<DepartmentsProvider>()
        .getCoursesDataByMajorDepartmentName(user.department);
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final majorDepartment =
        context.watch<DepartmentsProvider>().majorDepartment;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Register Your Courses',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        body: _isLoading
            ? Center(
                child: LoadingWidget(),
              )
            : Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3.0),
                            child: Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'CS 205',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(text: ' '),
                                      TextSpan(
                                        text: '2hr',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .button
                                                    .color
                                                    .withOpacity(0.5),
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(text: ' '),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  child: Icon(
                                    Icons.clear,
                                    size: 16.0,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  onTap: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: (MediaQuery.of(context).size.height * 100) /
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
                                          text: '10',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              .copyWith(
                                                  fontSize: 48.0,
                                                  fontWeight: FontWeight.w700),
                                        ),
//                                  TextSpan(
//                                    text: '/18',
//                                    style: TextStyle(
//                                        color: kPrimaryColor.withOpacity(
//                                            0.5), //Colors.black.withOpacity(0.4),
//                                        fontSize: 24.0,
//                                        fontWeight: FontWeight.w700),
//                                  ),
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
//                        crossAxisAlignment: CrossAxisAlignment,
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
                                              text: '6',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            TextSpan(
                                              text: '/10',
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
                                              text: '4',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            TextSpan(
                                              text: '/10',
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontSize: 14.0,
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
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                      tabs: [
                        FittedBox(
                          child: Tab(
                            text: "Department",
                          ),
                        ),
                        FittedBox(
                          child: Tab(
                            text: "University",
                          ),
                        ),
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
                        RegisterCourseWidget(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
