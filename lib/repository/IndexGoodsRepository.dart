import 'dart:convert';

import 'package:demo1/modals/Result.dart';
import 'package:demo1/util/result_obj_util.dart';
import 'package:demo1/modals/goods_list_modal.dart';
import 'package:loading_more_list/loading_more_list.dart';
import '../util/request_service.dart';

class IndexGoodsRepository extends LoadingMoreBase<GoodsItem> {
  int pageindex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  int pageSize = 50; // 每页条数，默认为100，最大值200，若小于10，则按10条处理，每页条数仅支持输入10,50,100,200

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
    await getGoodsListFuture({'pageId': pageindex, 'pageSize': pageSize})
        .then((res) {
      if (res != null) {
        Result result = ResultUtils.format(res);
        if (result != null && result.code == 200 && result.data != null) {
          GoodsList goodsList = GoodsList.fromJson(json.decode(result.data));
          if (goodsList.code == 0) {
            List<GoodsItem> newList = goodsList.data.list;
            // 成功加载数据
            if (newList.length != pageSize) {
              // 如果加载过来 的数据不足[pageSize]条,则设置不存在下一页
              _hasMore = false;
            }

            if (pageindex == 1) {
              clear();
            }

            for (var item in newList) {
              if (!contains(item) && hasMore) {
                add(item);
              }
            }

            pageindex++;
            isSuccess = true;
          }
        } else {
          print("加载商品列表失败!");
          isSuccess = false;
        }
      } else {
        isSuccess = false;
      }
    });

    return isSuccess;
  }
}
