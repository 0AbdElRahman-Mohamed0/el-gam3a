import 'package:elgam3a/models/day_model.dart';
import 'package:elgam3a/services/vars.dart';

class HallModel {
  int id;
  int capacity;
  String building;
  List<DayModel> days = [];

  HallModel({this.id, this.capacity});

  HallModel.fromMap(Map<String, dynamic> m) {
    id = m[HallData.ID];
    capacity = m[HallData.CAPACITY];
    m[HallData.DAYS].forEach((day) => days.add(DayModel.fromMap(day)));
    building = m[HallData.BUILDING];
  }

  Map<String, dynamic> toMap() {
    return {
      HallData.ID: id,
      HallData.CAPACITY: capacity,
      HallData.DAYS: days.map((day) => day.toMap()).toList(),
      HallData.BUILDING: building,
    };
  }

  @override
  String toString() {
    return 'Hall $id';
  }
}
