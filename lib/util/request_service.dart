import 'dart:convert';

import 'package:demo1/modals/Result.dart';
import 'package:demo1/util/result_obj_util.dart';
import 'package:demo1/util/system_toast.dart';

import './api.dart';
import './request.dart';
import '../modals/shop_info.dart';

// 这里类似java中的service

Future getIndexData(data){
  return post(Api.API_INDEX_DATA,data:data);
}

Future getDetailData(data){
  return post(Api.API_DETAIL_DATA,data:data);
}

// 获取轮播图数据
Future getCarouselData(data){
  return post(Api.API_CAROUSEL_DATA,data: data);
}

// 获取商品榜单数据
Future getRankingList(data){
  return post(Api.API_DTK_GET_RANK_LIST,data: data);
}
// 获取商品详情数据
Future getGoodsInfo(data){
  return post(Api.API_DTK_GET_GOODS_DETAIL_INFO,data:data);
}

// 获取商品库
Future getGoodsListFuture(data){
  return post(Api.API_DTK_GET_GOODS_LIST,data:data);
}
//获取商品优惠券资讯
Future getPrivilegeLink(data){
  return post(Api.API_DTK_GET_PRIVILEGE,data: data);
}

//获取9.9包邮商品
Future getNineGoods(data){
  return post(Api.API_DTK_GET_NINE_GOODS,data: data);
}

//获取大淘客超级分类
Future getDtkCategorys(){
  return post(Api.API_DTK_GET_CATEGORYS);
}
//获取大淘客钉钉抢商品
Future getDtkDdqGoods(data){
  return post(Api.API_DTK_GET_DDQ,data: data);
}

//用户登录
Future userLogin(data){
  return post(Api.API_USER+"/login",data: data);
}

// 添加商品收藏
Future addGoodsFavorite(data){
  return post(Api.API_FAVORITE+"/add",data: data);
}

// 判断用户是否收藏该商品
Future haveGoodsFavorite(data){
  return post(Api.API_FAVORITE+"/have",data: data);
}

// 用户移除某个商品收藏
Future removeGoodsFavorite(data){
  return post(Api.API_FAVORITE+"/remove",data: data);
}

// 获取用户收藏商品列表
Future loadFavoriteGoods(data){
  return post(Api.API_FAVORITE+'/list',data: data);
}

// 订单绑定接口
Future addOrder(data){
  return post(Api.API_ORDER+"/add",data: data);
}

// 获取订单列表
Future findOrderList(data){
  return post(Api.API_ORDER+"/list",data: data);
}

// 获取好订单详情接口,需要传入一个商品id:goods_id
Future getHaodankuDetailInfo(String goods_id){
  return post(Api.API_HDK_DETAIL,data: {"goods_id":goods_id});
}

// 首页网格菜单
Future getIndexGridSpecial(){
  return post(Api.API_INDEX_GRID_SPECIAL);
}

// 获取商店信息
Future<ShopInfo> getShopInfo(String shopName) async {
  await post(Api.API_GET_SHOP_INFO,data:{"shopName":shopName}).then((res){
    Result result = ResultUtils.format(res);
    if(result.code==200){
      ShopInfo shopInfo = ShopInfo.fromJson(json.decode(result.data.toString()));
      return shopInfo;
    }else{
      SystemToast.show(result.msg);
      return null;
    }
  });
}
