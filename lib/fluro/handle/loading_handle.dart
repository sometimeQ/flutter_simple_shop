import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../../loading.dart';
// 应用加载页面广告

var LoadingHandle = new Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return new LoadingPage();
  }
);