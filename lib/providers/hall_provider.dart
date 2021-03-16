import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class HallProvider extends ChangeNotifier {
  String hallDetails;
  HallProvider({this.hallDetails});
}
