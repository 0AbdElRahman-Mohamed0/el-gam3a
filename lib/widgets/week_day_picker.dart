import 'dart:collection';

import 'package:elgam3a/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selection_picker/selection_item.dart';

class WeekDayPicker extends StatefulWidget {
  final List<SelectionItem> items;
  final Function(SelectionItem) onSelected;
  final bool showTitle;
  final Text title;
  final Color backgroundColorSelected;
  final Color backgroundColorNoSelected;
  final Color textColor;
  final Alignment alignment;

  WeekDayPicker(
      {@required final this.items,
      this.showTitle,
      this.title,
      this.backgroundColorSelected,
      this.backgroundColorNoSelected,
      this.textColor,
      this.alignment,
      @required this.onSelected});

  @override
  _WeekDayPickerState createState() => _WeekDayPickerState();
}

class _WeekDayPickerState extends State<WeekDayPicker> {
  //// selectedDay will be only one item.
  SelectionItem selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
//      margin: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _showTitle(widget.showTitle),
          Container(
            alignment: widget.alignment,
            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
              ///// 7 week days
              children: _createItems(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showTitle(bool select) {
    if (select && widget.title != null) {
      return Container(
          margin:
              EdgeInsets.only(left: 10.0, right: 16.0, top: 16.0, bottom: 12.0),
          alignment: Alignment.centerLeft,
          child: widget.title);
    } else {
      return Container();
    }
  }

  ///// Create 7 days buttons & get the selected day
  List<Widget> _createItems() {
    List<Widget> days = [];

    _checkIdentifiers();

    widget.items.forEach((item) {
      final widgetItem = Expanded(
        child: Container(
          width: 50,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
                color: _setSelectedColor(item.isSelected),
                shape: BoxShape.circle),
            padding: EdgeInsets.all(1.0),
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 5.0),
            child: InkWell(
              onTap: () async {
                setState(() {
                  //// to make all the buttons not selected
                  // then make the selected day isSelected = true
                  if (item.isSelected == false) {
                    widget.items.forEach((item) {
                      item.isSelected = false;
                    });
                    item.isSelected = true;
                    _addToSelectedDays(item);
                  }
                  widget.onSelected(selectedDay);
                });
                await context
                    .read<AuthProvider>()
                    .getScheduleCourses(item.name);
              },
              child: _setName(item.name),
//              shape: CircleBorder(),
//              color: _setSelectedColor(item.isSelected),
            ),
          ),
        ),
      );
      days.add(widgetItem);
    });

    return days;
  }

  //// Get the selected day
  _addToSelectedDays(SelectionItem day) {
    selectedDay = day;
  }

  Widget _setName(String name) {
    var colorItem = widget.textColor != null ? widget.textColor : Colors.black;

    if (name.length >= 3) {
      return Text(
        name.substring(0, 3),
        style: TextStyle(
            color: colorItem, fontWeight: FontWeight.bold, fontSize: 15.0),
      );
    }
    return Text(
      name,
      style: TextStyle(
          color: colorItem, fontWeight: FontWeight.bold, fontSize: 17.0),
    );
  }

  Color _setSelectedColor(bool selected) {
    if (selected) {
      return widget.backgroundColorSelected != null
          ? widget.backgroundColorSelected
          : Colors.black12;
    } else {
      return widget.backgroundColorNoSelected != null
          ? widget.backgroundColorNoSelected
          : Colors.transparent;
    }
  }

  void _checkIdentifiers() {
    List<dynamic> identifiers = [];

    widget.items.forEach((item) {
      identifiers.add(item.identifier);
    });

    if (identifiers.isNotEmpty) {
      List<dynamic> result = LinkedHashSet<dynamic>.from(identifiers).toList();
      if (result.length != identifiers.length) {
        throw "There are duplicated identifiers in Items Array , the item identifier must be unique";
      }
    }
  }
}
