import 'package:flutter/material.dart';
import 'dart:convert';
import '../util/result_obj_util.dart';
import '../util/request_service.dart';
import '../modals/NineGoodsData.dart';
import '../modals/Result.dart';

class NineGoodsProvider with ChangeNotifier {

  List<NineGoodsItem> goods = [];
  String currentNineCid = "-1";
  int page = 1;

  loadNineGoodsList(String pageId , String cid) async {
    if(cid==""){
      cid = currentNineCid;
    }
    await getNineGoods({"pageId":pageId,"nineCid":cid}).then((res){
     Result result = ResultUtils.format(res);
     if(result.code==200 && result.data!=null){
       NineGoodsData goodsData =NineGoodsData.fromJson(json.decode(result.data.toString()));
       if(goodsData.code==0){
         if(pageId!="1"){
           goods.addAll(goodsData.data.list);
         }else{
           goods = goodsData.data.list;
         }
         notifyListeners();
       }else{
         print("大淘客数据错误");
       }
     }else{
       print("获取9.9包邮商品失败");
     }
    });
  }

  setCurrentNineCid(String cid){
    currentNineCid = cid;
  }

  loadNextPageData(){
    page++;
    this.loadNineGoodsList(page.toString(), currentNineCid);
  }
}
