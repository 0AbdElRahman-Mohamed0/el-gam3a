import 'package:elgam3a/widgets/faculties_dropdown_list.dart';
import 'package:flutter/material.dart';

class FacultiesPart extends StatelessWidget {
  final String day;
  FacultiesPart({this.day});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FacultiesDropDownList(listTitle: 'El-Shatbi'),
        FacultiesDropDownList(listTitle: 'Moharem Bek'),
        FacultiesDropDownList(listTitle: 'El-Anfoshi'),
      ],
    );
  }
}
