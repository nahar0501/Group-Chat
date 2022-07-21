
import 'package:shared_preferences/shared_preferences.dart';

class Prefs
{
  static Future setUserid(String id)async
  {
    final pref=await SharedPreferences.getInstance();
    pref.setString("userid", id);
  }

  static Future<String> getUserid()async
  {
    final pref=await SharedPreferences.getInstance();
    return pref.getString("userid") ?? "";
  }
}