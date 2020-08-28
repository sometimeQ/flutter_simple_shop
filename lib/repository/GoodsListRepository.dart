import 'dart:convert';

import 'package:demo1/modals/Result.dart';
import 'package:demo1/util/result_obj_util.dart';
import 'package:flutter/material.dart';
import 'package:demo1/modals/goods_list_modal.dart';
import 'package:loading_more_list/loading_more_list.dart';
import '../util/request_service.dart';

class GoodsListRepository extends LoadingMoreBase<GoodsItem> {
  int pageindex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  int pageSize = 50; // 每页条数，默认为100，最大值200，若小于10，则按10条处理，每页条数仅支持输入10,50,100,200

  //外面传进来的参数
  String g_sort;
  String brand;
  String cids;
  String subcid;

  GoodsListRepository({this.g_sort, this.brand, this.cids, this.subcid});

  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    pageindex = 1;
    forceRefresh = !clearBeforeRequest;
    var result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    bool isSuccess = false;
    print(
        "正在获取第${pageindex}页数据,排序:${g_sort},品牌:${brand},主类目:${cids},子类目:${subcid}");
    await getGoodsListFuture({
      "pageId": pageindex,
      "sort": g_sort,
      "brand": brand,
      "cids": cids,
      "subcid": subcid,
      "pageSize": pageSize
    }).then((res) {
      Result result = ResultUtils.format(res);
      if (result.data != null && result.code == 200) {
        GoodsList _goods =
            GoodsList.fromJson(json.decode(result.data.toString()));
        if (_goods.code == 0) {
          if (pageSize != _goods.data.list.length) {
            _hasMore = false;
          }

          if (pageindex == 1) {
            clear();
          }

          for (var item in _goods.data.list) {
            if (!contains(item) && hasMore) {
              add(item);
            }
          }

          pageindex++;
          isSuccess = true;
          print("获取数据成功");
        } else {
          isSuccess = false;
        }
      } else {
        isSuccess = false;
      }
    });

    return isSuccess;
  }
}
