import 'package:demo1/pages/user_home_page/order/my_order.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var orderAllHandle = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String stype = params["stype"]?.first;
    return MyOrderHomePage(stype: stype,);
  }
);