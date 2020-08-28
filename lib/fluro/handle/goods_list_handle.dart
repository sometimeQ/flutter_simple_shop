import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../pages/goods_page/index_home.dart';

var GoodsListHandle = Handler(
    handlerFunc: (BuildContext bc, Map<String, List<String>> params) {
      String subcid = params["subcid"]?.first;
      String cids = params["cids"]?.first;
      String brand = params["brand"]?.first;
      String title = params["title"]?.first;
      String showCates = params["showCates"]?.first;
      return new GoodsListPage(subcid: subcid,brand: brand,cids: cids,title:title,showCates:showCates);
    });
