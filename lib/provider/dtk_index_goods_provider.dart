import 'package:flutter/material.dart';
import '../util/request_service.dart';
import '../modals/RankData.dart';
import '../modals/Result.dart';
import '../modals/goods_list_modal.dart';
import '../util/result_obj_util.dart';
import 'dart:convert';

class DtkIndexGoodsModal with ChangeNotifier {
  List<Datum> goods = [];

  int page = 1; // 默认加载商品第一页数据
  List<GoodsItem> indexGoods = []; // 首页商品列表

  bool noMore = false; // 是否存在下一页 ,false 有,true没有下一页了
  bool isLoading = false; // 是否在加载数据中

  // 获取商品列表数据
  getGoodsList(page) async {
    await getGoodsListFuture({'pageId': page, 'pageSize': 10}).then((res) {
      Result result = ResultUtils.format(res);
      if (result.code == 200 && result.data != null) {
        GoodsList goodsList = GoodsList.fromJson(json.decode(result.data));
        if (goodsList.code == 0) {
          List<GoodsItem> newList = goodsList.data.list;
          // 成功加载数据
          if (page == 1) {
            // 加载第一页数据
            indexGoods = newList;
          } else {
            //加载下一页数据
            indexGoods.addAll(newList);
          }
          if (newList.length != 10) {
            // 如果加载过来 的数据不足20条,则设置不存在下一页
            noMore = true;
          }
          notifyListeners();
        }
      } else {
        print("加载商品列表失败!");
      }
    });
  }

  setLoadingState(bool isLoading) {
    isLoading = isLoading;
    notifyListeners();
  }

  getNextPageData() {
    page++;
    getGoodsList(page);
  }

  // 获取榜单数据
  getRankGoodsList() async {
    await getRankingList({'rankType': 1}).then((res) {
      Result result = ResultUtils.format(res);
      if (result.code == 200) {
        final obj = RankListGoods.fromJson(json.decode(result.data.toString()));
        goods = obj.data;
        notifyListeners();
      } else {
        print("获取数据榜单失败");
      }
    });
  }
}
