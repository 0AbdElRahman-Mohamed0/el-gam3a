import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickPhotoPopUp extends StatelessWidget {
  final Function takePhotoOnPressed;
  final Function pickPhotoOnPressed;

  PickPhotoPopUp({
    @required this.takePhotoOnPressed,
    @required this.pickPhotoOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Choose how to set photo'),
      content: Column(
        children: <Widget>[
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                onPressed: takePhotoOnPressed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Camera'),
              ),
              RaisedButton(
                onPressed: pickPhotoOnPressed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: Text('Gallery'),
              ),
            ],
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
