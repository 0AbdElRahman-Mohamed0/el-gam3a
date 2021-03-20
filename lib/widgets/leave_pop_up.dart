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
            style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 14),
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => SystemNavigator.pop(),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      'Yes',
                      style: Theme.of(context).textTheme.button.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Theme.of(context).accentColor,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF000000).withOpacity(0.34),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Text(
                      'No',
                      style: Theme.of(context).textTheme.button.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
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
