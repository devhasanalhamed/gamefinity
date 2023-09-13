import 'package:flutter/material.dart';
import 'package:gamefinity/core/services/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String? local;
  updateLocal(String? lang) {
    local = lang;
    SharedPref.addLang(lang!);
    notifyListeners();
  }
}
