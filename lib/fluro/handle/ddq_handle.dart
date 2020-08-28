import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../pages/ddq_page/index_home.dart';

var DdqHandle = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return DdqIndexHome();
  }
);