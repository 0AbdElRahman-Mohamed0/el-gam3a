import 'package:flutter/material.dart';
import 'package:elgam3a/utilities/constants.dart';
import 'package:selection_picker/selectionpicker.dart';
import 'package:selection_picker/selection_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Utilities {
  static List<SelectionItem> getDays() {
    List<SelectionItem> days = [];
    days.add(SelectionItem(name: "MO", isSelected: false, identifier: 1));
    days.add(SelectionItem(name: "TU", isSelected: false, identifier: 2));
    days.add(SelectionItem(name: "WE", isSelected: false, identifier: 3));
    days.add(SelectionItem(name: "TH", isSelected: false, identifier: 4));
    days.add(SelectionItem(name: "FR", isSelected: false, identifier: 5));
    days.add(SelectionItem(name: "SA", isSelected: false, identifier: 6));
    days.add(SelectionItem(name: "SU", isSelected: false, identifier: 7));
    return days;
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('My Schedule'),
        ),
        body: SelectionPicker(
          items: Utilities.getDays(),
          showSelectAll: false,
          //textColor: Color(0xFF003A5D),
          //selectAllTitle: Text("Select all"),
          showTitle: true,
          title: Text(
            "Week days",
          ),
          backgroundColorSelected: Colors.black12,
          onSelected: (item) {
            //Items selected here
          },
          aligment: Alignment.center,
        ),
      ),
    );
  }
}
