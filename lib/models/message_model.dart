import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String message;
  String imagePath;
  String imageUrl;
  String senderName;
  String senderEmail;
  DateTime time;
  MessageModel(
      {this.message,
      this.id,
      this.senderEmail,
      this.senderName,
      this.time,
      this.imagePath,
      this.imageUrl});
  MessageModel.fromMap(Map m) {
    id = m['id'];
    message = m['message'];
    senderName = m['senderName'];
    imagePath = m['imagePath'];
    imageUrl = m['imageUrl'];
    senderEmail = m['senderName'];
    time = (m['time'] as Timestamp).toDate();
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'senderName': senderName,
      'senderEmail': senderEmail,
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
    String senderEmail,
    DateTime time,
  }) =>
      MessageModel(
        id: id ?? this.id,
        message: message ?? this.message,
        imagePath: imagePath ?? this.imagePath,
        imageUrl: imageUrl ?? this.imageUrl,
        senderName: senderName ?? this.senderName,
        senderEmail: senderEmail ?? this.senderEmail,
        time: time ?? this.time,
      );
}
