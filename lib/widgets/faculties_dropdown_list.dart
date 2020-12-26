import 'package:elgam3a/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:animate_icons/animate_icons.dart';

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
    return Column(
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
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: AnimateIcons(
                    startIcon: Icons.keyboard_arrow_down,
                    endIcon: Icons.keyboard_arrow_up,
                    controller: _animationController,
                    duration: Duration(milliseconds: 200),
                    clockwise: false,
                    color: Color(0xFF707070).withOpacity(0.54),
                    size: 25.0,
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
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Text(
                            'Lectures  ',
                            style: TextStyle(
                              color: Color(0xFF155E9F).withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '(2 lectures)',
                            style: TextStyle(
                              color: Color(0xFF155E9F).withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    LectureTimeInSchedule(),
                    LectureTimeInSchedule(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0, top: 10.0),
                      child: Row(
                        children: [
                          Text(
                            'Section  ',
                            style: TextStyle(
                              color: Color(0xFF155E9F).withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '(2 sections)',
                            style: TextStyle(
                              color: Color(0xFF155E9F).withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    LectureTimeInSchedule(),
                    LectureTimeInSchedule(),
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }
}

class LectureTimeInSchedule extends StatelessWidget {
  const LectureTimeInSchedule({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 5.0),
              padding: EdgeInsets.only(left: 8.0, top: 10.0, bottom: 6.0),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Machine learning',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Dr. Reham - Dr. Nermin',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 5.0),
              padding: EdgeInsets.only(top: 10.0, bottom: 6.0),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3 pm - 5 pm',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Hall (5) - Build (B)',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
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
