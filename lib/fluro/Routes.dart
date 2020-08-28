import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

// handle
import 'handle/home_handle.dart';
import 'handle/goods_detail_handle.dart';
import 'handle/error_handle.dart';
import 'handle/goods_list_handle.dart';
import 'handle/ddq_handle.dart';
import 'handle/white_handle.dart';
import 'handle/user_handle.dart';
import 'handle/order_add_handle.dart';
import 'handle/order_all_handle.dart';
import 'handle/hdk_detail_handle.dart';
// handle ---end

class Routes {
  static String root = "/"; // 首页
  static String home = "/home"; // 进入应用显示的页面
  static String goodsDetail = "/goodsDetail"; // 商品详情页面
  static String error = '/error'; // 错误页面
  static String goodsList = '/goodsList'; //商品列表页面
  static String ddq = '/ddq'; //钉钉抢页面


  //_-------------------------用户相关页面
  static String userLoginPgae= "/user_login";  // 用户登入页面
  static String white = '/white';// 用户发布动态页面

  //----------------------------订单相关页面
  static String orderAdd = "/order_add"; // 绑定订单页面
  static String orderAll = "/order_all"; // 全部订单列表页面

  //---------------------------------好单库相关页面
  static String hdkDetail = "/hdk_detail"; // 商品详情

  static void configureRoutes(Router router) {
    // 定义404
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("页面404");
    });

    // 定义首页路由
    router.define(home, handler: HomeHandel);
    router.define(goodsDetail, handler: GoodsDetailHandle);
    router.define(goodsList, handler: GoodsListHandle);
    router.define(ddq, handler: DdqHandle);
    router.define(error, handler: errorHandle);
    router.define(userLoginPgae, handler: userLoginHandle);
    router.define(white, handler: whiteHandle);
    router.define(orderAdd, handler: orderAddHandle);
    router.define(orderAll, handler: orderAllHandle);
    router.define(hdkDetail, handler: hdkDetailHandle);
  }
}
