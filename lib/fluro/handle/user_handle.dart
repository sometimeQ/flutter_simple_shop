import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../pages/user_home_page/login/login_page.dart';

// 用户登录
var userLoginHandle = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return UserLoginPage();
  }
);