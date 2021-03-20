import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a/models/message_model.dart';
import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/course_provider.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/bottom_chat_bar.dart';
import 'package:elgam3a/widgets/chat_receive_widget.dart';
import 'package:elgam3a/widgets/chat_send_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:rflutter_alert/rflutter_alert.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController message = TextEditingController();
  File _image;
  String _uploadedFileURL;
  bool isLoading = true;

  final firestore = FirebaseFirestore.instance;

  Future<void> _pickImage() async {
    print('ffffff');
    final currentUser = context.read<AuthProvider>().user;

    final pFile = await ImagePicker().getImage(source: ImageSource.gallery);
    LoadingScreen.show(context);

    if (pFile != null) {
      if (mounted)
        setState(() {
          _image = File(pFile.path);
        });
      await uploadFile(context);
      final course = context.read<CourseProvider>().course;
      await sendData(
        MessageModel(
            imagePath: _imagesFolderPath,
            imageUrl: _uploadedFileURL,
            senderEmail: currentUser.email,
            senderName: currentUser.name,
            time: DateTime.now()),
        course.courseCode,
      );
      Navigator.pop(context);
    }
  }

  Future<void> uploadFile(BuildContext context) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(_imagesFolderPath);
      await ref.putFile(_image);
      await ref.getDownloadURL().then((fileURL) {
        _uploadedFileURL = fileURL;
        if (mounted) setState(() {});
      });
    } on FirebaseException catch (e) {
      Alert(
        context: context,
        title: 'Couldn\'t Upload your file',
        desc: e.message,
      ).show();
    } catch (e) {
      Alert(
        context: context,
        title: 'Couldn\'t Upload your file, Please try again.',
      ).show();
    }
  }

  String get _imagesFolderPath => "chatImages"
      "/${Path.basename(_image.path)}";

  Future<void> sendData(MessageModel msg, String courseCode) async {
    if (msg == null) return;
    if (message == null) return;
    try {
      message.clear();
      final chat = await firestore
          .collection('chats')
          .where('courseCode', isEqualTo: courseCode)
          .get();
      final DocumentReference data = await firestore
          .collection('chats')
          .doc(chat.docs.first.id)
          .collection('messages')
          .add(msg.toMap());
      await firestore
          .collection('chats')
          .doc(chat.docs.first.id)
          .update({'updated_at': DateTime.now()});
      await firestore
          .collection('chats')
          .doc(chat.docs.first.id)
          .collection('messages')
          .doc(data.id)
          .update({'id': data.id});
      msg = null;
    } on FirebaseException catch (e) {
      if (e.code == 'network-request-failed') {
        print(' error ${e.code}');
        Alert(
          context: context,
          title: 'Please check your internet connection!',
          style: AlertStyle(
            alertElevation: 0,
          ),
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ).show();
      } else {
        Alert(
          context: context,
          title: '${e.message}',
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
    } catch (e) {
      Alert(
        context: context,
        title: 'Something wrong happened, please try again',
        buttons: [
          DialogButton(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).cardColor
                ]),
            child: Text(
              'Okay',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    message.dispose();
  }

  @override
  void initState() {
    super.initState();
    data();
  }

  data() async {
    try {
      final course = context.read<CourseProvider>().course;

      chat = await firestore
          .collection('chats')
          .where('courseCode', isEqualTo: course.courseCode)
          .get();
      setState(() {
        isLoading = false;
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'network-request-failed') {
        print(' error ${e.code}');
        Alert(
          context: context,
          title: 'Please check your internet connection!',
          style: AlertStyle(
            alertElevation: 0,
          ),
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ).show();
      } else {
        Alert(
          context: context,
          title: '${e.message}',
          buttons: [
            DialogButton(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).cardColor
                  ]),
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Alert(
        context: context,
        title: 'Something wrong happened, please try again',
        buttons: [
          DialogButton(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).cardColor
                ]),
            child: Text(
              'Okay',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
  }

  QuerySnapshot chat;

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<AuthProvider>().user;
    final course = context.watch<CourseProvider>().course;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              '${course.courseName}',
              style: Theme.of(context).appBarTheme.textTheme.headline1.copyWith(
                    fontSize: 20,
                  ),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '(${course.courseCode})',
              style: Theme.of(context)
                  .appBarTheme
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: isLoading
                  ? LoadingWidget()
                  : chat.docs.isEmpty
                      ? Center(
                          child: Text('No messages'),
                        )
                      : StreamBuilder<QuerySnapshot>(
                          stream: firestore
                              .collection('chats')
                              .doc(chat.docs.first.id)
                              .collection('messages')
                              .orderBy('time', descending: true)
                              .snapshots(includeMetadataChanges: true),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            return ListView(
                              controller: _scrollController,
                              reverse: true,
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot document) {
                                if (document.data()['senderEmail'] ==
                                        currentUser.email ||
                                    document.data()['senderName'] ==
                                        currentUser.name) {
                                  return ChatSendWidget(
                                      message: MessageModel(
                                    id: document.data()['id'],
                                    message: document.data()['message'],
                                    senderName: currentUser.name,
                                    senderEmail: document.data()['senderEmail'],
                                    time:
                                        ((document.data()['time'] as Timestamp)
                                            .toDate()),
                                    imageUrl: document.data()['imageUrl'],
                                    imagePath: document.data()['imagePath'],
                                  ));
                                } else {
                                  return ChatReceiveWidget(
                                      message: MessageModel(
                                    id: document.data()['id'],
                                    message: document.data()['message'],
                                    senderName: document.data()['senderName'],
                                    senderEmail: document.data()['senderEmail'],
                                    senderImage: document.data()['senderImage'],
                                    time:
                                        ((document.data()['time'] as Timestamp)
                                            .toDate()),
                                    imageUrl: document.data()['imageUrl'],
                                    imagePath: document.data()['imagePath'],
                                  ));
                                }
                              }).toList(),
                            );
                          }),
            ),
            BottomChatBar(
              image: _image,
              message: message,
              uploadedFileURL: _uploadedFileURL,
              sendFunction: () => sendData(
                  MessageModel(
                      message: message.text,
                      senderEmail: currentUser.email,
                      senderName: currentUser.name,
                      senderImage: currentUser.imageUrl,
                      time: DateTime.now()),
                  course.courseCode),
              sendImage: () => _pickImage(),
//              takeImage: () => takeImage(),
            ),
          ],
        ),
      ),
    );
  }
}
