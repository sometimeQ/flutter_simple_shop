// To parse this JSON data, do
//
//     final dtkDdqModal = dtkDdqModalFromJson(jsonString);

import 'dart:convert';

DtkDdqModal dtkDdqModalFromJson(String str) => DtkDdqModal.fromJson(json.decode(str));

String dtkDdqModalToJson(DtkDdqModal data) => json.encode(data.toJson());

class DtkDdqModal {
  int time;
  int code;
  String msg;
  DdqData data;

  DtkDdqModal({
    this.time,
    this.code,
    this.msg,
    this.data,
  });

  factory DtkDdqModal.fromJson(Map<String, dynamic> json) => DtkDdqModal(
    time: json["time"],
    code: json["code"],
    msg: json["msg"],
    data: DdqData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "code": code,
    "msg": msg,
    "data": data.toJson(),
  };
}

class DdqData {
  DateTime ddqTime;
  int status;
  List<DdqGoodsListItem> goodsList;
  List<RoundsList> roundsList;

  DdqData({
    this.ddqTime,
    this.status,
    this.goodsList,
    this.roundsList,
  });

  factory DdqData.fromJson(Map<String, dynamic> json) => DdqData(
    ddqTime: DateTime.parse(json["ddqTime"]),
    status: json["status"],
    goodsList: List<DdqGoodsListItem>.from(json["goodsList"].map((x) => DdqGoodsListItem.fromJson(x))),
    roundsList: List<RoundsList>.from(json["roundsList"].map((x) => RoundsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ddqTime": ddqTime.toIso8601String(),
    "status": status,
    "goodsList": List<dynamic>.from(goodsList.map((x) => x.toJson())),
    "roundsList": List<dynamic>.from(roundsList.map((x) => x.toJson())),
  };
}

class DdqGoodsListItem {
  int id;
  String goodsId;
  String itemLink;
  String title;
  String dtitle;
  int cid;
  List<int> subcid;
  String ddqDesc;
  String mainPic;
  double originalPrice;
  double actualPrice;
  double couponPrice;
  double discounts;
  String couponLink;
  DateTime couponEndTime;
  DateTime couponStartTime;
  String couponConditions;
  int commissionType;
  double commissionRate;
  DateTime createTime;
  int couponReceiveNum;
  int couponTotalNum;
  int monthSales;
  int activityType;
  String activityStartTime;
  String activityEndTime;
  String shopName;
  int shopLevel;
  String sellerId;
  int brand;
  int brandId;
  String brandName;
  int twoHoursSales;
  int dailySales;
  int quanMLink;
  int hzQuanOver;
  int yunfeixian;
  double estimateAmount;
  int tbcid;

  DdqGoodsListItem({
    this.id,
    this.goodsId,
    this.itemLink,
    this.title,
    this.dtitle,
    this.cid,
    this.subcid,
    this.ddqDesc,
    this.mainPic,
    this.originalPrice,
    this.actualPrice,
    this.couponPrice,
    this.discounts,
    this.couponLink,
    this.couponEndTime,
    this.couponStartTime,
    this.couponConditions,
    this.commissionType,
    this.commissionRate,
    this.createTime,
    this.couponReceiveNum,
    this.couponTotalNum,
    this.monthSales,
    this.activityType,
    this.activityStartTime,
    this.activityEndTime,
    this.shopName,
    this.shopLevel,
    this.sellerId,
    this.brand,
    this.brandId,
    this.brandName,
    this.twoHoursSales,
    this.dailySales,
    this.quanMLink,
    this.hzQuanOver,
    this.yunfeixian,
    this.estimateAmount,
    this.tbcid,
  });

  factory DdqGoodsListItem.fromJson(Map<String, dynamic> json) => DdqGoodsListItem(
    id: json["id"],
    goodsId: json["goodsId"],
    itemLink: json["itemLink"],
    title: json["title"],
    dtitle: json["dtitle"],
    cid: json["cid"],
    subcid: List<int>.from(json["subcid"].map((x) => x)),
    ddqDesc: json["ddqDesc"],
    mainPic: json["mainPic"],
    originalPrice: json["originalPrice"].toDouble(),
    actualPrice: json["actualPrice"].toDouble(),
    couponPrice: json["couponPrice"],
    discounts: json["discounts"].toDouble(),
    couponLink: json["couponLink"],
    couponEndTime: DateTime.parse(json["couponEndTime"]),
    couponStartTime: DateTime.parse(json["couponStartTime"]),
    couponConditions: json["couponConditions"],
    commissionType: json["commissionType"],
    commissionRate: json["commissionRate"].toDouble(),
    createTime: DateTime.parse(json["createTime"]),
    couponReceiveNum: json["couponReceiveNum"],
    couponTotalNum: json["couponTotalNum"],
    monthSales: json["monthSales"],
    activityType: json["activityType"],
    activityStartTime: json["activityStartTime"],
    activityEndTime: json["activityEndTime"],
    shopName: json["shopName"],
    shopLevel: json["shopLevel"],
    sellerId: json["sellerId"],
    brand: json["brand"],
    brandId: json["brandId"],
    brandName: json["brandName"],
    twoHoursSales: json["twoHoursSales"],
    dailySales: json["dailySales"],
    quanMLink: json["quanMLink"],
    hzQuanOver: json["hzQuanOver"],
    yunfeixian: json["yunfeixian"],
    estimateAmount: json["estimateAmount"].toDouble(),
    tbcid: json["tbcid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "goodsId": goodsId,
    "itemLink": itemLink,
    "title": title,
    "dtitle": dtitle,
    "cid": cid,
    "subcid": List<dynamic>.from(subcid.map((x) => x)),
    "ddqDesc": ddqDesc,
    "mainPic": mainPic,
    "originalPrice": originalPrice,
    "actualPrice": actualPrice,
    "couponPrice": couponPrice,
    "discounts": discounts,
    "couponLink": couponLink,
    "couponEndTime": couponEndTime.toIso8601String(),
    "couponStartTime": couponStartTime.toIso8601String(),
    "couponConditions": couponConditions,
    "commissionType": commissionType,
    "commissionRate": commissionRate,
    "createTime": createTime.toIso8601String(),
    "couponReceiveNum": couponReceiveNum,
    "couponTotalNum": couponTotalNum,
    "monthSales": monthSales,
    "activityType": activityType,
    "activityStartTime": activityStartTime,
    "activityEndTime": activityEndTime,
    "shopName": shopName,
    "shopLevel": shopLevel,
    "sellerId": sellerId,
    "brand": brand,
    "brandId": brandId,
    "brandName": brandName,
    "twoHoursSales": twoHoursSales,
    "dailySales": dailySales,
    "quanMLink": quanMLink,
    "hzQuanOver": hzQuanOver,
    "yunfeixian": yunfeixian,
    "estimateAmount": estimateAmount,
    "tbcid": tbcid,
  };
}

class RoundsList {
  DateTime ddqTime;
  int status;

  RoundsList({
    this.ddqTime,
    this.status,
  });

  factory RoundsList.fromJson(Map<String, dynamic> json) => RoundsList(
    ddqTime: DateTime.parse(json["ddqTime"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "ddqTime": ddqTime.toIso8601String(),
    "status": status,
  };
}
