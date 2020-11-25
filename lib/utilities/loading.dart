import 'package:elgam3a/utilities/constants.dart';
import 'package:flutter/material.dart' hide FontWeight;
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  final Indicator indicator;
  final double size;

  const LoadingWidget({
    Key key,
    this.size = 150,
    this.indicator = Indicator.ballScale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        child: LoadingIndicator(
          indicatorType: indicator,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}

class LoadingScreen {
  LoadingScreen._();

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoadingWidget(
                indicator: Indicator.ballScale,
              )
            ],
          ),
        );
      },
    );
  }
}
