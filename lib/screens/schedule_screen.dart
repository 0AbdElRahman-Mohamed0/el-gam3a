import 'package:elgam3a/widgets/faculties_part.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:elgam3a/widgets/week_day_picker.dart';
import 'package:selection_picker/selection_item.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

//// List of week days
class Utilities {
  static List<SelectionItem> getDays() {
    List<SelectionItem> days = [];
    days.add(SelectionItem(name: "SAT", isSelected: true, identifier: 1));
    days.add(SelectionItem(name: "SUN", isSelected: false, identifier: 2));
    days.add(SelectionItem(name: "MON", isSelected: false, identifier: 3));
    days.add(SelectionItem(name: "TUE", isSelected: false, identifier: 4));
    days.add(SelectionItem(name: "WED", isSelected: false, identifier: 5));
    days.add(SelectionItem(name: "THU", isSelected: false, identifier: 6));
    days.add(SelectionItem(name: "FRI", isSelected: false, identifier: 7));
    return days;
  }
}
//Gesuture Detector
// expanded = false

class _ScheduleScreenState extends State<ScheduleScreen> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  String day;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          WeekDayPicker(
            items: Utilities.getDays(),
            textColor: Color(0xFF003A5D),
            showTitle: true,
            title: Text(
              "Week days",
              style: kWeekDaysTitleTextStyle,
            ),

            //// with opacity 38%
            backgroundColorSelected: kSelectedCalenderItemColor,
            onSelected: (item) {
              //// to check which day is selected
              print(item.name);
              day = item.name;
              //  TODO: change screen
            },
            alignment: Alignment.center,
          ),
          kSizedBoxForPagesStyle,
          FacultiesPart(day: day),
        ],
      ),
    );
  }
}
