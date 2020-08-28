import 'dart:convert';

import 'package:demo1/provider/base_provider.dart';
import '../modals/goods_list_modal.dart';
import '../util/request_service.dart';
import '../util/result_obj_util.dart';
import '../modals/Result.dart';

class GoodsListProvider extends BaseProvider {
  List<GoodsItem> goods = [];

  //排序方式，默认为0，0-综合排序，1-商品上架时间从高到低，2-销量从高到低，3-领券量从高到低，4-佣金比例从高到低，5-价格（券后价）从高到低，6-价格（券后价）从低到高
  List<int> desc = [0, 1, 2, 5, 6];
  int currentIndex = 0; // 默认综合排序
  int page = 1; //默认第几页
  String brand = "";//品牌id,默认0

  String cids = "";
  String subcid = "";

  LoadList() async {
//    changeLoadingState(true);
  print("pageId:${page},sort:${desc[currentIndex]},brand:${brand},subcid:${this.subcid},cids:${cids}");
    await getGoodsListFuture({"pageId":page,"sort":desc[currentIndex],"brand":brand,"cids":cids,"subcid":subcid,"pageSize":10}).then((res) {
      Result result = ResultUtils.format(res);
      if(result.data!=null && result.code==200){
        GoodsList _goods = GoodsList.fromJson(json.decode(result.data.toString()));
        if(_goods.code==0){
          if(page==1){
            goods  = _goods.data.list;
          }else{
            goods.addAll(_goods.data.list);
          }
          notifyListeners();
        }else{
          print("获取商品列表失败---------------------GoodsListProvider-");
        }
      }else{
        print("获取商品列表失败---------------------GoodsListProvider-");
      }
//      changeLoadingState(false);
    });
  }

  reFresh() async{
   this.page==1;
   this.goods = [];
   await LoadList();
  }

  nextPage(){
    this.page++;
    LoadList();
  }

  subcidSele(subcid) async{
    this.subcid = subcid;
  }

  pop(){
    goods = [];
    page = 1;
    cids = "";
    subcid = "";
    currentIndex = 0; // 默认综合排序
    brand = "";
  }

  sort(curr){
    this.currentIndex = curr;
  }
}
