// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';
import 'user_model.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  User user;
  String token;

  UserData({
    this.user,
    this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}
