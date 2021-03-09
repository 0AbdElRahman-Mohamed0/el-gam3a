import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeavePopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        'Exit ?',
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(fontWeight: FontWeight.w700),
      ),
      content: Column(
        children: <Widget>[
          SizedBox(height: 24.0),
          Text(
            'Do you want to close app ?',
            style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 12),
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () => SystemNavigator.pop(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Yes'),
              ),
              SizedBox(width: 12.0),
              RaisedButton(
                onPressed: () => Navigator.pop(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: Text('No'),
              ),
            ],
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
