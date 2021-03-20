import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDataModel {
  String id;
  String number;
  String name;
  String pdfUrl;
  String pdfPath;
  DateTime time;

  CourseDataModel({
    this.name,
    this.pdfUrl,
    this.number,
    this.id,
    this.time,
    this.pdfPath,
  });

  CourseDataModel.fromMap(Map m) {
    id = m['id'];
    name = m['name'];
    pdfPath = m['pdfPath'];
    number = m['number'];
    pdfUrl = m['pdfUrl'];
    time = (m['time'] as Timestamp).toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'time': time,
      'pdfUrl': pdfUrl,
      'pdfPath': pdfPath,
    };
  }

  CourseDataModel copyWith({
    String id,
    String pdfPath,
    String pdfUrl,
    String number,
    String name,
    DateTime time,
  }) =>
      CourseDataModel(
        id: id ?? this.id,
        pdfPath: pdfPath ?? this.pdfPath,
        pdfUrl: pdfUrl ?? this.pdfUrl,
        name: name ?? this.name,
        number: number ?? this.number,
        time: time ?? this.time,
      );
}
