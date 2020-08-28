import 'dart:convert';

import 'package:demo1/modals/Result.dart';
import 'package:demo1/util/result_obj_util.dart';
import 'package:flutter/material.dart';
import 'package:demo1/modals/NineGoodsData.dart';
import 'package:loading_more_list/loading_more_list.dart';
import '../util/request_service.dart';

class JiuJiuRepository extends LoadingMoreBase<NineGoodsItem> {
  int pageIndex = 1; // 默认第一页
  bool _hasMore = true; // 是否还存在下一页
  String cid; // 类别ID
  bool forceRefresh = false;

  JiuJiuRepository(this.cid);

  @override
  // TODO: implement hasMore
  bool get hasMore => _hasMore;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    pageIndex = 1;
    forceRefresh = !notifyStateChanged;
    var result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    print("进来了;${cid}");
    bool isSuccess = false; // 是否加载成功
    await getNineGoods({"pageId": pageIndex, "nineCid": cid}).then((res) {
      Result result = ResultUtils.format(res);
      if (result.code == 200 && result.data != null) {
        NineGoodsData goodsData =
            NineGoodsData.fromJson(json.decode(result.data.toString()));
        if (goodsData.code == 0) {

          NineGoodsData goodsData =NineGoodsData.fromJson(json.decode(result.data.toString()));

          if(goodsData.data.list.length!=20){
            _hasMore = false;
          }

          if(pageIndex==1) clear();

          for (var item in goodsData.data.list) {
            if (!contains(item) && hasMore) {
              add(item);
            }
          }

          pageIndex++;
          isSuccess= true;
        } else {
          isSuccess = false;
        }
      } else {
        isSuccess = false;
      }
      return isSuccess;
    });
    return isSuccess;
  }
}
