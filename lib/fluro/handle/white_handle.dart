import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../pages/user_home_page/white/index.dart';

// 发布动态
var whiteHandle = Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return WhiteIndex();
    }
);