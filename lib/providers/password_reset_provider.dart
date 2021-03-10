import 'package:flutter/material.dart';

class PasswordResetProvider extends ChangeNotifier {
  bool emailSent = false;

  updateEmailSent() {
    emailSent = true;
    notifyListeners();
  }
}
