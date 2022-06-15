import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static const String _id = "ID";
  static const String _nama = "user";
  static const String _email = "user@email.com";
  // set
  static void setId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_id, value);
  }

  static void setName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_nama, value);
  }

  static void setEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_email, value);
  }

  // get
  static Future<String?> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_id);
  }
  static Future<String?> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nama);
  }
  static Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_email);
  }
  
  // remove
  static Future<bool> removeId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_id);
  }

  //cek
  static Future<bool> checkUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_id);
  }
}
