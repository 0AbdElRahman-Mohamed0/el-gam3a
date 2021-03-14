import 'package:elgam3a/models/hall_model.dart';
import 'package:elgam3a/services/vars.dart';

class FacultyModel {
  String id;
  String name;
  List<HallModel> halls = [];

  FacultyModel.fromMap(Map<String, dynamic> m) {
    id = m[FacultyData.ID];
    name = m[FacultyData.NAME];
    if (m[FacultyData.HALLS] != null) {
      m[FacultyData.HALLS]
          .forEach((hall) => halls.add(HallModel.fromMap(hall)));
    }
  }

  @override
  String toString() {
    return name;
  }
}
