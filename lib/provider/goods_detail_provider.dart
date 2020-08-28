import 'dart:convert';

import 'package:demo1/modals/couponData.dart';
import 'package:flutter/material.dart';
import '../util/request_service.dart';
import '../modals/Result.dart';
import '../modals/GoodsInfo.dart';
import '../util/result_obj_util.dart';
import '../util/user_utils.dart';

class GoodsDetailProvider with ChangeNotifier {
  GoodsDetail goodInfo; // 商品信息
  CouponData couponData; // 优惠券信息
  int isHaveFav = 0; // 是否已经收藏,0 - 没有,1 - 有
  bool have = false; // 商品是否有效

  // 获取商品详情信息
  getGoodsDetailInfo(String goods_id) async {
    await getGoodsInfo({'id': goods_id}).then((res) {
      Result resultObj = ResultUtils.format(res);
      if (resultObj.code == 200) {
        var dtkCode = json.decode(resultObj.data.toString())["code"];
        if (dtkCode == 0) {
          var _goodInfo =
              GoodsInfo.fromJson(json.decode(resultObj.data.toString()));
          goodInfo = _goodInfo.data;
          have = true;
          notifyListeners();
        } else {
          var dtkMsg = json.decode(resultObj.data.toString())["msg"];
          print('${dtkMsg}');
        }
      } else {
        print("${resultObj.msg}");
      }
    });
  }

  setNullInfo() {
    goodInfo = null;
    couponData = null;
    have = false;
    isHaveFav = 0;
  }

  // 用户添加商品收藏
  Future<bool> addGoodsFavoriteFun() async {
    // 判断用户是否登录
    await UserUtil.loadUserInfo().then((user) async {
      if (user != null) {
        await addGoodsFavorite({"goods": goodInfo, "userId": user.id})
            .then((res) {
          Result result = ResultUtils.format(res);
          if (result.code == 200 && int.parse(result.data) == 1) {
            print("收藏成功!");
            isHaveFav = 1;
            notifyListeners();
          } else if (result.code == 200 && int.parse(result.data) == 2) {
            print("已收藏");
          }
        });
      } else {
        print("请先登录!");
      }
    });
    return true;
  }

  // 用户移除某个商品收藏
  Future<bool> removeGoodsFavoriteFun({String goodsId}) async {
    String _goodsId = goodsId;
    if(goodsId==null){
      _goodsId = this.goodInfo.id.toString();
    }
    // 判断用户是否已经登录
    await UserUtil.loadUserInfo().then((user) async {
      if (user != null) {
        await removeGoodsFavorite({"goodsId": _goodsId, "userId": user.id})
            .then((res) {
          Result result = ResultUtils.format(res);
          if (result.code == 200 && int.parse(result.data) == 1) {
            isHaveFav = 0;
            notifyListeners();
            print("取消收藏成功!");
          } else {
            print("取消收藏失败!");
          }
        });
      }
    });
    return true;
  }

  // 判断收藏按钮显示
  void haveFav() async {
    // 判断用户是否已经登录
    await UserUtil.loadUserInfo().then((user) async {
      if (user != null) {
        if (goodInfo != null) {
        await haveGoodsFavorite({'goodsId': goodInfo.id, "userId": user.id})
              .then((res) {
            print("${res}");
            Result result = ResultUtils.format(res);
            print('${res}');
            if (result.code == 200) {
              this.isHaveFav = int.parse(result.data);
              notifyListeners();
            }
          });
        } else {
          // 商品不存在
          have = false;
        }
      }
    });
  }

  // 获取优惠券信息
  getPrivilegeLinkData(String goods_id) async {
    await getPrivilegeLink({'goodsId': goods_id}).then((res) {
      Result resultObj = ResultUtils.format(res);
      if (resultObj.code == 200) {
        CouponInfo couponInfo =
            CouponInfo.fromJson(json.decode(resultObj.data.toString()));
        if (couponInfo.code == 0) {
          // 加载成功
          print("加载成功:${couponInfo.msg.toString()}");
          couponData = couponInfo.data;
          notifyListeners();
        }
      } else {
        print("加载优惠券信息失败");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    goodInfo = null;
  }
}
