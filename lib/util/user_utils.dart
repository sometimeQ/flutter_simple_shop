import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modals/user_model.dart';
import "../modals/user_data.dart";

class UserUtil{

  static Future<SharedPreferences> refs = SharedPreferences.getInstance();

  static Future<User> loadUserInfo() async {
    SharedPreferences _refs = await refs;
    String userInfoJsonStr = _refs.getString("userInfo");
    if (userInfoJsonStr == null) {
      return null;
    }
    UserData userData = UserData.fromJson(json.decode(userInfoJsonStr));
    return userData.user;
  }

  static void setUserInfo(String json) async {
    SharedPreferences _refs = await refs;
    _refs.setString("userInfo", json);
  }

  static void removeUserInfoData() async {
    SharedPreferences _refs = await refs;
    _refs.remove("userInfo");
  }
}