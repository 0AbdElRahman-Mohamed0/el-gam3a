import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/schedule_provider.dart';
import 'package:elgam3a/widgets/faculties_part.dart';
import 'package:elgam3a/widgets/week_day_picker.dart';
import 'package:flutter/material.dart';
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
  String day;
  List<SelectionItem> days = [];
  SelectionItem selectedItem;
  @override
  void initState() {
    super.initState();
    days.add(SelectionItem(name: "SAT", isSelected: true, identifier: 1));
    days.add(SelectionItem(name: "SUN", isSelected: false, identifier: 2));
    days.add(SelectionItem(name: "MON", isSelected: false, identifier: 3));
    days.add(SelectionItem(name: "TUE", isSelected: false, identifier: 4));
    days.add(SelectionItem(name: "WED", isSelected: false, identifier: 5));
    days.add(SelectionItem(name: "THU", isSelected: false, identifier: 6));
    days.add(SelectionItem(name: "FRI", isSelected: false, identifier: 7));
    selectedItem = days.first;
  }

  @override
  Widget build(BuildContext context) {
//    final courses = context.watch<AuthProvider>().courses;
//    print(courses.length);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
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
              print('${selectedItem.name} - ${selectedItem.isSelected}');

//                item.isSelected = true;
//              });
              //  TODO: change screen
            },
            alignment: Alignment.center,
          ),
          Divider(
            color: Theme.of(context).dividerColor,
          ),
          ChangeNotifierProvider<ScheduleProvider>(
            create: (_) => ScheduleProvider(selectedItem),
            child: FacultiesPart(item: selectedItem),
          ),
        ],
      ),
    );
  }
}
