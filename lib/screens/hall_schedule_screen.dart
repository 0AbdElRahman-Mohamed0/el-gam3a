import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/providers/courses_provider.dart';
import 'package:elgam3a/providers/hall_provider.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/week_day_picker.dart';
import 'package:flutter/material.dart';
import 'package:selection_picker/selection_item.dart';

class HallScheduleScreen extends StatefulWidget {
  @override
  _HallScheduleScreenState createState() => _HallScheduleScreenState();
}

class _HallScheduleScreenState extends State<HallScheduleScreen> {
  String day;
  List<SelectionItem> days = [];
  SelectionItem selectedItem;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _resetFilter();
      _filterData();
    });
    days.add(SelectionItem(name: "SAT", isSelected: true, identifier: 1));
    days.add(SelectionItem(name: "SUN", isSelected: false, identifier: 2));
    days.add(SelectionItem(name: "MON", isSelected: false, identifier: 3));
    days.add(SelectionItem(name: "TUE", isSelected: false, identifier: 4));
    days.add(SelectionItem(name: "WED", isSelected: false, identifier: 5));
    days.add(SelectionItem(name: "THU", isSelected: false, identifier: 6));
    days.add(SelectionItem(name: "FRI", isSelected: false, identifier: 7));
    selectedItem = days.first;
  }

  _resetFilter() {
    context.read<CoursesProvider>().resetFilter();
  }

  _filterData() {
    final facultyName = context.read<HallProvider>().hallDetails.split(',')[0];
    final hall = context.read<HallProvider>().hallDetails.split(',')[1];
    context.read<CoursesProvider>().filterData(facultyName, num.parse(hall));
  }

  @override
  Widget build(BuildContext context) {
    final facultyName = context.watch<HallProvider>().hallDetails.split(',')[0];
    final hall = context.watch<HallProvider>().hallDetails.split(',')[1];
    final filteredCourses = context.watch<CoursesProvider>().filteredCourses;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Hall $hall',
              style: Theme.of(context).appBarTheme.textTheme.headline1,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '($facultyName)',
              style: Theme.of(context)
                  .appBarTheme
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
      body: filteredCourses == null
          ? Center(
              child: LoadingWidget(),
            )
          : filteredCourses.isEmpty
              ? Center(
                  child: Text(
                    'There are no courses',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                )
              : Column(
                  children: [
                    WeekDayPicker(
                      items: days,
                      textColor: Color(0xff050737),
                      showTitle: true,
                      title: Text(
                        "Week days",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      //// with opacity 38%
                      backgroundColorSelected:
                          Theme.of(context).shadowColor.withOpacity(0.5),
                      onSelected: (item) {
                        //// to check which day is selected
//              setState(() {
                        day = item.name;
                        setState(() {
                          selectedItem = item;
                        });
                        print(
                            '${selectedItem.name} - ${selectedItem.isSelected}');

//                item.isSelected = true;
//              });
                        //  TODO: change screen
                      },
                      alignment: Alignment.center,
                    ),
                    Divider(
                      color: Theme.of(context).dividerColor,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                      child: Column(
                        children: filteredCourses.map(
                          (course) {
                            if (course.courseDay
                                .toLowerCase()
                                .contains(selectedItem.name.toLowerCase())) {
                              return ChangeNotifierProvider<CourseProvider>(
                                create: (_) => CourseProvider(course),
                                child: HallScheduleCard(),
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.only(top: 150),
                              child: Text(
                                'There are no courses this day',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
    );
  }
}

class HallScheduleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final course = context.watch<CourseProvider>().course;
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${course.courseName}', //'Machine learning'
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                '${course.courseTime}',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          Text(
            'Dr. ${course.courseDoctor}',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 14.0, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
