import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String message;
  String imagePath;
  String imageUrl;
  String senderName;
  String senderImage;
  String senderEmail;
  DateTime time;
  MessageModel({
    this.message,
    this.id,
    this.senderEmail,
    this.senderName,
    this.time,
    this.imagePath,
    this.senderImage,
    this.imageUrl,
  });
  MessageModel.fromMap(Map m) {
    id = m['id'];
    message = m['message'];
    senderName = m['senderName'];
    imagePath = m['imagePath'];
    imageUrl = m['imageUrl'];
    senderImage = m['senderImage'];
    senderEmail = m['senderName'];
    time = (m['time'] as Timestamp).toDate();
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'senderImage': senderImage,
      'time': time,
      'imageUrl': imageUrl,
      'imagePath': imagePath,
    };
  }

  MessageModel copyWith({
    String id,
    String message,
    String imagePath,
    String imageUrl,
    String senderName,
    String senderImage,
    String senderEmail,
    DateTime time,
  }) =>
      MessageModel(
        id: id ?? this.id,
        message: message ?? this.message,
        imagePath: imagePath ?? this.imagePath,
        imageUrl: imageUrl ?? this.imageUrl,
        senderName: senderName ?? this.senderName,
        senderImage: senderImage ?? this.senderImage,
        senderEmail: senderEmail ?? this.senderEmail,
        time: time ?? this.time,
      );
}
