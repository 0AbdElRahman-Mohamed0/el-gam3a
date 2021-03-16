import 'package:animate_icons/animate_icons.dart';
import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/schedule_course_provider.dart';
import 'package:flutter/material.dart';

class FacultiesDropDownList extends StatefulWidget {
  FacultiesDropDownList({
    @required this.listTitle,
//    @required this.listName,
  });

  final String listTitle;
//  final List<MonthContainer> listName;

  @override
  _FacultiesDropDownListState createState() => _FacultiesDropDownListState();
}

class _FacultiesDropDownListState extends State<FacultiesDropDownList>
    with SingleTickerProviderStateMixin {
  String listTitle;
//  List<MonthContainer> listName;
  bool showList = false;
  AnimateIconController _animationController;

  @override
  void initState() {
    super.initState();
    listTitle = widget.listTitle;
//    listName = widget.listName;
    _animationController = AnimateIconController();
  }

  void _handleOnPressed() {
    if (_animationController.isStart()) {
      setState(() {
        showList = true;
      });
      _animationController.animateToEnd();
    } else if (_animationController.isEnd()) {
      setState(() {
        showList = false;
      });
      _animationController.animateToStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<AuthProvider>().mySchedule;
    final collegeCourses =
        courses.where((element) => element.courseLocation == widget.listTitle);
    return collegeCourses.isEmpty
        ? SizedBox()
        : Column(
            children: [
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: showList
                        ? BorderSide.none
                        : BorderSide(
                            color: Color(0xFF707070).withOpacity(0.16),
                          ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 26.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        listTitle,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      IconButton(
                        icon: AnimateIcons(
                          startIcon: Icons.keyboard_arrow_down,
                          endIcon: Icons.keyboard_arrow_up,
                          controller: _animationController,
                          duration: Duration(milliseconds: 200),
                          clockwise: false,
                          startIconColor: Color(0xFF707070).withOpacity(0.54),
                          endIconColor: Color(0xFF707070).withOpacity(0.54),
                          size: 24.0,
                          startTooltip: '',
                          endTooltip: '',
                          onEndIconPress: () {
                            setState(() {
                              showList = false;
                            });
                            print(showList);
                            return true;
                          },
                          onStartIconPress: () {
                            setState(() {
                              showList = true;
                            });
                            print(showList);
                            return true;
                          },
                        ),
                        onPressed: () => _handleOnPressed(),
                      ),
                    ],
                  ),
                ),
              ),
              showList
                  ?
//        courses.isEmpty
//                ? LoadingWidget()
//                :
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              children: collegeCourses.length == 0
                                  ? [SizedBox()]
                                  : [
                                      Text(
                                        'Lectures  ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      Text(
                                        '(${collegeCourses.length} lectures)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            .copyWith(
                                              fontSize: 14,
                                            ),
                                      )
                                    ],
                            ),
                          ),
                          ...collegeCourses.map(
                            (course) =>
                                ChangeNotifierProvider<ScheduleCourseProvider>(
                              create: (_) => ScheduleCourseProvider(course),
                              child: LectureTimeInSchedule(),
                            ),
                          ),
//                    LectureTimeInSchedule(),
//                    LectureTimeInSchedule(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.0, top: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Section  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                Text(
                                  '(2 sections)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                          ),
//                    LectureTimeInSchedule(),
//                    LectureTimeInSchedule(),
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          );
  }
}

class LectureTimeInSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final course = context.watch<ScheduleCourseProvider>().course;
    final user = context.watch<AuthProvider>().user;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 5.0),
              padding: EdgeInsets.only(
                  left: 8.0,
                  top: user.type == 'Student' ? 10.0 : 16.0,
                  bottom: user.type == 'Student' ? 6.0 : 16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${course.courseName}', //'Machine learning'
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  user.type == 'Student'
                      ? Text(
                          'Dr. ${course.courseDoctor}',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 5.0),
              padding: EdgeInsets.only(top: 10.0, bottom: 6.0),
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                children: [
                  Text(
                    '${course.courseTime}',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    'Hall (${course.courseHall}) - Build (${course.courseBuilding})',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
