import '/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Prefs
{
 static Future setUserData(String json)async
  {
    final pref=await SharedPreferences.getInstance();
    pref.setString("userdata", json);
  }
 static Future<UserModel?> getUserData()async
  {
    final pref=await SharedPreferences.getInstance();
    String data=pref.getString("userdata") ?? "";
    if(data.isNotEmpty)
      {
        return UserModel.fromRawJson(data);
      }
    return null;
  }

}