import 'package:demo1/pages/user_home_page/order/order_add.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var orderAddHandle = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return OrderAddIndexPage();
  }
);