import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/schedule_provider.dart';
import 'package:elgam3a/widgets/faculties_dropdown_list.dart';
import 'package:flutter/material.dart';
import 'package:selection_picker/selection_item.dart';

class FacultiesPart extends StatefulWidget {
  final SelectionItem item;
  FacultiesPart({this.item});

  @override
  _FacultiesPartState createState() => _FacultiesPartState();
}

class _FacultiesPartState extends State<FacultiesPart> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initData();
    });
  }

  initData() async {
    await context.read<AuthProvider>().getScheduleCourses(widget.item.name);
  }

  @override
  Widget build(BuildContext context) {
    final itemm = context.watch<ScheduleProvider>().item;
    print('day ${widget.item.name}');
    final courses = context.watch<AuthProvider>().mySchedule;
    print(courses.length);

    return courses.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Text(
                    'Day OFF',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ])
        : Column(
            children: [
              FacultiesDropDownList(listTitle: 'El-Shatby'),
              FacultiesDropDownList(listTitle: 'Moharem-Bek'),
              FacultiesDropDownList(listTitle: 'El-Anfoshy'),
            ],
          );
  }
}
