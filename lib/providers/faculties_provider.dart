import 'package:elgam3a/models/day_model.dart';
import 'package:elgam3a/models/faculty_model.dart';
import 'package:elgam3a/models/hall_model.dart';
import 'package:elgam3a/services/api.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class FacultiesProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider.instance;
  List<FacultyModel> faculties;

  Future<void> getFaculties() async {
    faculties = await _api.getFaculties();
    notifyListeners();
  }

  Future<void> updateHallTimes(
      {HallModel hall, FacultyModel faculty, DayModel day, String time}) async {
    final halls =
        faculties.firstWhere((element) => element.id == faculty.id).halls;
    final days = halls.firstWhere((element) => element.id == hall.id).days;
    final times = days.firstWhere((element) => element.name == day.name).times;
    times.removeWhere((element) => element == time);

    await _api.updateHall(halls, faculty.id);
  }
}
