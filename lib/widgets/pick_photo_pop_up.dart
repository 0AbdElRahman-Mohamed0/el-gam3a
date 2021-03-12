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
              InkWell(
                onTap: takePhotoOnPressed,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF000000).withOpacity(0.34),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  child: Text(
                    'Camera',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: pickPhotoOnPressed,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF000000).withOpacity(0.34),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  child: Text(
                    'Gallery',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
