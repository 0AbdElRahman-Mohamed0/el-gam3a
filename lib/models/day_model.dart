class DayModel {
  String name;
  List<String> times = [];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'times': times,
    };
  }

  DayModel.fromMap(Map<String, dynamic> m) {
    name = m['name'];
    m['times'].forEach((time) => times.add(time));
  }

  @override
  String toString() {
    return name;
  }
}
