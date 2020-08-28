import 'dart:convert';

import 'package:flutter/material.dart';
import '../modals/Result.dart';
import '../util/result_obj_util.dart';
import '../modals/ddq_modal.dart';
import '../util/request_service.dart';
import '../util/system_toast.dart';

// 钉钉抢转态管理
class DdqProvider with ChangeNotifier {

  List<DdqGoodsListItem> goodsList = [];
  List<RoundsList> roundsList = [];
  DateTime ddqTime;
  int status;

  //时间段
  String dateTime = "";

  loadData() async {
    var data = dateTime=="" ? {} : {"roundTime":dateTime.substring(0,dateTime.length-4)};
    await getDtkDdqGoods(data).then((res){
      Result result = ResultUtils.format(res);
      if(result!=null && result.code==200){
        DtkDdqModal ddqModal = DtkDdqModal.fromJson(json.decode(result.data.toString()));
        if(ddqModal!=null && ddqModal.code==0){
          if(dateTime==""){
            goodsList = ddqModal.data.goodsList;
            roundsList = ddqModal.data.roundsList;
            ddqTime=ddqModal.data.ddqTime;
            status =ddqModal.data.status;
          }else{
            goodsList = ddqModal.data.goodsList;
          }
          notifyListeners();
        }else{
          SystemToast.show("获取商品失败");
        }
      }else{
        SystemToast.show("服务器错误");
      }
    });
  }

  timeChange(DateTime time,int state) async {
    this.ddqTime = time;
    this.goodsList=[];
    this.status=state;
    this.dateTime = time.toString();
    this.loadData();
  }

}