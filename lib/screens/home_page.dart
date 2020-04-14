import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:elgam3a/services/week_day_picker.dart';
import 'package:selection_picker/selection_item.dart';
import '../utilities/my_app_bar.dart';
import '../services/side_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//// List of week days
class Utilities {
  static List<SelectionItem> getDays() {
    List<SelectionItem> days = [];
    days.add(SelectionItem(name: "SAT", isSelected: false, identifier: 1));
    days.add(SelectionItem(name: "SUN", isSelected: false, identifier: 2));
    days.add(SelectionItem(name: "MON", isSelected: false, identifier: 3));
    days.add(SelectionItem(name: "TUE", isSelected: false, identifier: 4));
    days.add(SelectionItem(name: "WED", isSelected: false, identifier: 5));
    days.add(SelectionItem(name: "THU", isSelected: false, identifier: 6));
    days.add(SelectionItem(name: "FRI", isSelected: false, identifier: 7));
    return days;
  }
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: drawerKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: MyAppBar(
            title: Text('My Schedual'),
            drawerKey: drawerKey,
          ),
        ),
        drawer: SideMenu(
          userName: 'Bedo',
        ),
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
          ],
        ),
      ),
    );
  }
}
