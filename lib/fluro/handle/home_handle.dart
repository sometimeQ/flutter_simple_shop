import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../../pages/index_page/index_home.dart';

var HomeHandel = new Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return new IndexHome();
  }
);