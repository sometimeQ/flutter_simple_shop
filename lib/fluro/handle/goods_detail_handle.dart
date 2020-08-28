
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../pages/detail_page/index_home.dart';

var GoodsDetailHandle = new Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String goodsId = params["goods_id"]?.first;
    return DetailIndex(goods_id:goodsId);
  }
);