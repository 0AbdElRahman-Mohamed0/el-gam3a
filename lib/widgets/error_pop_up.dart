import 'package:flutter/cupertino.dart' hide FontWeight;
import 'package:flutter/material.dart' hide FontWeight;

class ErrorPopUp extends StatelessWidget {
  final String message;
  final String title;

  ErrorPopUp({@required this.message, this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? 'Error!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 24.0),
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 24.0),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 44,
              width: 128,
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
              child: Center(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
