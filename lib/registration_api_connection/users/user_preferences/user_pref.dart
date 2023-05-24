import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class SaveUserInfo {
  static Future<void> saveUserData(User userInfo) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    String userJsonData = jsonEncode(userInfo.toJson());
    await sharedPref.setString("rememberUser", userJsonData);
  }

  static Future<User?> readUser() async {
    User? currentUserInfo;
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userInfo = sharedPref.getString("rememberUser");
    if (userInfo != null) {
      Map<String, dynamic>userDataMap = jsonDecode(userInfo);
      currentUserInfo = User.fromJson(userDataMap);
    }
    return currentUserInfo;
  }
}