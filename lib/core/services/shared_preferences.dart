import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String? lang;

  static initSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    lang = pref.getString('lang');
  }

  static addLang(String lang) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('lang', lang);
  }

  static Future<String?> getLang() async {
    final pref = await SharedPreferences.getInstance();
    lang = pref.getString('lang');
    return lang;
  }
}
