import 'package:flutter/material.dart';
import 'package:selection_picker/selection_item.dart';

export 'package:provider/provider.dart';

class ScheduleProvider with ChangeNotifier {
  SelectionItem item;
  ScheduleProvider(this.item);
}
