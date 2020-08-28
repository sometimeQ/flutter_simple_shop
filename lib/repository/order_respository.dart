import 'dart:convert';

import 'package:demo1/modals/Result.dart';
import 'package:demo1/modals/order_list_model.dart';
import 'package:demo1/modals/page_info_model.dart';
import 'package:demo1/util/request_service.dart';
import 'package:demo1/util/result_obj_util.dart';
import 'package:demo1/util/user_utils.dart';
import 'package:loading_more_list/loading_more_list.dart';


class OrderRespository extends LoadingMoreBase<OrderAuditObject>{

  int pageIndex = 1; // 默认第一页
  bool _hasMore = true; // 是否还存在下一页
  bool forceRefresh = false;

  String stype; // 类别ID
  OrderRespository({this.stype:"-1"});
  
  @override
  // TODO: implement hasMore
  bool get hasMore => _hasMore;
  
  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    
    bool isSuccess = false;
    
    await UserUtil.loadUserInfo().then((user) async {
      if(user!=null){
        await findOrderList({"userId":user.id,"pageId":pageIndex,"stype":stype}).then((res){
          Result result = ResultUtils.format(res);
          if(result.code==200){

            OrderAllData orderAllData = OrderAllData.fromJson(json.decode(result.data));
            _hasMore = !orderAllData.last;

            if(pageIndex==1) clear();

            List<OrderAuditObject> content = orderAllData.content;

            for(OrderAuditObject item in content){
              if(!contains(item)){
                add(item);
              }
            }

            pageIndex++;

            isSuccess = true;
            print("加载数据成功");
          }else{
            print(result.msg);
          }
        });
      }else{
        print("请先登录");
      }
    });
    
    return isSuccess;
  }


  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    pageIndex = 1;
    forceRefresh = !notifyStateChanged;
    var result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

}