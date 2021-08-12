import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData(String key) {
    
    return sharedPreferences.get(key);
  }

  static Future setData({@required String key, @required dynamic value}) async {
    if (value is int)
      return await sharedPreferences.setInt(key, value);
    else if (value is String)
      return await sharedPreferences.setString(key, value);
    else if (value is bool)
      return await sharedPreferences.setBool(key, value);
    else
      return await sharedPreferences.setDouble(key, value);
  }


  static Future<void> removeData(String key)async
   {
    return await sharedPreferences.remove(key);
   }
}
