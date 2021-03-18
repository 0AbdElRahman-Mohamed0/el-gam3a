import 'dart:io';

import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';

class BottomChatBar extends StatefulWidget {
  TextEditingController message = TextEditingController();
  final File image;
  final String uploadedFileURL;
  final Function sendFunction;
  final Function sendImage;
  final Function takeImage;
  BottomChatBar({
    this.message,
    this.uploadedFileURL,
    this.image,
    this.sendFunction,
    this.sendImage,
    this.takeImage,
  });
  @override
  _BottomChatBarState createState() => _BottomChatBarState();
}

class _BottomChatBarState extends State<BottomChatBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).buttonColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.takeImage,
            child: Container(
              height: 36.0,
              width: 36.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Center(
                child: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              validator: Validator(rules: [RequiredRule()]),
              controller: widget.message,
              onChanged: (v) {
                if (mounted) setState(() {});
              },
              style: Theme.of(context).textTheme.headline2.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                hintText: 'Message',
                hintStyle: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ),
          if (widget.message.text.isEmpty) ...[
            GestureDetector(
              onTap: widget.sendImage,
              child: Icon(Icons.image),
            ),
          ] else if (widget.message.text.isNotEmpty) ...[
            GestureDetector(
              onTap: widget.sendFunction,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'send',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
