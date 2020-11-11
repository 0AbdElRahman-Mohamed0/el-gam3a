import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:elgam3a/widgets/week_day_picker.dart';
import 'package:selection_picker/selection_item.dart';
import '../widgets/side_menu_animated_icon.dart';
import 'package:elgam3a/widgets/side_menu.dart';

class ScheduleScreen extends StatefulWidget {
  static const String id = 'schedule_screen';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
// //         key: drawerKey,
// //         appBar: AppBar(
// //           backgroundColor: kPrimaryColor,
// //           title: Text('My Schedule'),
// // //          leading: SideMenuAnimatedIcon(
// // //            drawerKey: drawerKey,
// // //          ),
// //         ),
//
//         drawer: SideMenu(
//           userName: 'Bedo',
//         ),
      ///// Days buttons Picker widget
      body: Column(
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
              },
              alignment: Alignment.center,
            ),
            kSizedBoxForPagesStyle,
            FacultiesDropDownList(listTitle: 'El-Shatbi'),
            FacultiesDropDownList(listTitle: 'Moharem Bek'),
            FacultiesDropDownList(listTitle: 'El-Anfoshi'),
          ],
        ),
      ),
    );
  }
}
