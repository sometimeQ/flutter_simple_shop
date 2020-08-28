import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../pages/other_page/not_found_page.dart';

var errorHandle = new Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return NotFoundPage();
  }
);