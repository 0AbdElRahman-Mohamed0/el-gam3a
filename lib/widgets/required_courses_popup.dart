import 'package:elgam3a/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RequiredCoursesPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2699FB).withOpacity(0.1),
            offset: Offset(0, 30),
            blurRadius: 30,
          ),
        ],
      ),
      margin: EdgeInsets.only(
        left: 24,
        right: 24,
        top: (MediaQuery.of(context).size.height * 130) / 667.0,
        bottom: (MediaQuery.of(context).size.height * 88) / 667.0,
      ),
      padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: SvgPicture.asset(
                  'assets/svg/close.svg',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Text(
            'Requiered',
            style: TextStyle(
                color: kPrimaryColor.withOpacity(0.5),
                fontSize: 12.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 16.0),
          Text(
            'Data Science and Mining',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w400),
          ),
          Text(
            'CS 309',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 16.0),
          Text(
            'Dr. Ahmed Yonis',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 24.0),
          Text(
            'Location',
            style: TextStyle(
                color: kPrimaryColor.withOpacity(0.5),
                fontSize: 12.0,
                fontWeight: FontWeight.w400),
          ),
          Text(
            'El-Anfoshi',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
