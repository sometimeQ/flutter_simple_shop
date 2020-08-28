import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}


class IndexGridSpecialDataModel {
  IndexGridSpecialDataModel({
    this.bottomThree,
    this.bottomFour,
    this.bottomOne,
    this.leftTopOne,
    this.rightTopOne,
    this.bottomTwo,
  });


  factory IndexGridSpecialDataModel.fromJson(Map<String, dynamic> jsonRes)=>jsonRes == null? null:IndexGridSpecialDataModel(    bottomThree : BottomThree.fromJson(asT<Map<String, dynamic>>(jsonRes['bottomThree'])),
    bottomFour : BottomFour.fromJson(asT<Map<String, dynamic>>(jsonRes['bottomFour'])),
    bottomOne : BottomOne.fromJson(asT<Map<String, dynamic>>(jsonRes['bottomOne'])),
    leftTopOne : LeftTopOne.fromJson(asT<Map<String, dynamic>>(jsonRes['leftTopOne'])),
    rightTopOne : RightTopOne.fromJson(asT<Map<String, dynamic>>(jsonRes['rightTopOne'])),
    bottomTwo : BottomTwo.fromJson(asT<Map<String, dynamic>>(jsonRes['bottomTwo'])),
  );

  BottomThree bottomThree;
  BottomFour bottomFour;
  BottomOne bottomOne;
  LeftTopOne leftTopOne;
  RightTopOne rightTopOne;
  BottomTwo bottomTwo;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'bottomThree': bottomThree,
    'bottomFour': bottomFour,
    'bottomOne': bottomOne,
    'leftTopOne': leftTopOne,
    'rightTopOne': rightTopOne,
    'bottomTwo': bottomTwo,
  };

  @override
  String  toString() {
    return json.encode(this);
  }
}
class BottomThree {
  BottomThree({
    this.tag,
    this.title,
    this.router,
    this.tagtextColor,
    this.goods,
    this.tagBgColor,
  });


  factory BottomThree.fromJson(Map<String, dynamic> jsonRes){ if(jsonRes == null){return null;}
  final List<GoodsInfo> goods = jsonRes['goods'] is List ? <GoodsInfo>[]: null;
  if(goods!=null) {
    for (final dynamic item in jsonRes['goods']) { if (item != null) { goods.add(GoodsInfo.fromJson(asT<Map<String,dynamic>>(item)));  } }
  }


  return BottomThree(tag : asT<String>(jsonRes['tag']),
    title : asT<String>(jsonRes['title']),
    router : asT<String>(jsonRes['router']),
    tagtextColor : asT<String>(jsonRes['tagtextColor']),
    goods:goods,
    tagBgColor : asT<String>(jsonRes['tagBgColor']),
  );}

  String tag;
  String title;
  String router;
  String tagtextColor;
  List<GoodsInfo> goods;
  String tagBgColor;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'tag': tag,
    'title': title,
    'router': router,
    'tagtextColor': tagtextColor,
    'goods': goods,
    'tagBgColor': tagBgColor,
  };

  @override
  String  toString() {
    return json.encode(this);
  }
}
class GoodsInfo {
  GoodsInfo({
    this.itempic_copy,
    this.itemendprice,
    this.todaysale,
    this.itemprice,
    this.itemtitle,
    this.shoptype,
    this.tktype,
    this.fqcat,
    this.tkrates,
    this.cuntao,
    this.tkmoney,
    this.couponurl,
    this.couponmoney,
    this.itemsale2,
    this.couponsurplus,
    this.couponreceive,
    this.couponnum,
    this.itemid,
    this.seller_id,
    this.product_id,
    this.itemdesc,
    this.itemsale,
    this.itempic,
    this.seller_name,
    this.activity_type,
    this.videoid,
    this.isquality,
    this.start_time,
    this.couponexplain,
    this.is_shipping,
    this.activityid,
    this.report_status,
    this.starttime,
    this.end_time,
    this.planlink,
    this.shopid,
    this.general_index,
    this.is_explosion,
    this.original_img,
    this.deposit,
    this.is_live,
    this.guide_article,
    this.tkurl,
    this.dx_rates,
    this.taobao_image,
    this.discount,
    this.sellernick,
    this.shopname,
    this.couponendtime,
    this.online_users,
    this.me,
    this.down_type,
    this.son_category,
    this.is_brand,
    this.userid,
    this.couponstarttime,
    this.coupon_condition,
    this.couponreceive2,
    this.itemshorttitle,
    this.todaycouponreceive,
    this.original_article,
    this.deposit_deduct,
  });


  factory GoodsInfo.fromJson(Map<String, dynamic> jsonRes)=>jsonRes == null? null:GoodsInfo(itempic_copy : asT<String>(jsonRes['itempic_copy']),
    itemendprice : asT<String>(jsonRes['itemendprice']),
    todaysale : asT<String>(jsonRes['todaysale']),
    itemprice : asT<String>(jsonRes['itemprice']),
    itemtitle : asT<String>(jsonRes['itemtitle']),
    shoptype : asT<String>(jsonRes['shoptype']),
    tktype : asT<String>(jsonRes['tktype']),
    fqcat : asT<String>(jsonRes['fqcat']),
    tkrates : asT<String>(jsonRes['tkrates']),
    cuntao : asT<String>(jsonRes['cuntao']),
    tkmoney : asT<String>(jsonRes['tkmoney']),
    couponurl : asT<String>(jsonRes['couponurl']),
    couponmoney : asT<String>(jsonRes['couponmoney']),
    itemsale2 : asT<String>(jsonRes['itemsale2']),
    couponsurplus : asT<String>(jsonRes['couponsurplus']),
    couponreceive : asT<String>(jsonRes['couponreceive']),
    couponnum : asT<String>(jsonRes['couponnum']),
    itemid : asT<String>(jsonRes['itemid']),
    seller_id : asT<String>(jsonRes['seller_id']),
    product_id : asT<String>(jsonRes['product_id']),
    itemdesc : asT<String>(jsonRes['itemdesc']),
    itemsale : asT<String>(jsonRes['itemsale']),
    itempic : asT<String>(jsonRes['itempic']),
    seller_name : asT<String>(jsonRes['seller_name']),
    activity_type : asT<String>(jsonRes['activity_type']),
    videoid : asT<String>(jsonRes['videoid']),
    isquality : asT<String>(jsonRes['isquality']),
    start_time : asT<String>(jsonRes['start_time']),
    couponexplain : asT<String>(jsonRes['couponexplain']),
    is_shipping : asT<String>(jsonRes['is_shipping']),
    activityid : asT<String>(jsonRes['activityid']),
    report_status : asT<String>(jsonRes['report_status']),
    starttime : asT<String>(jsonRes['starttime']),
    end_time : asT<String>(jsonRes['end_time']),
    planlink : asT<String>(jsonRes['planlink']),
    shopid : asT<String>(jsonRes['shopid']),
    general_index : asT<String>(jsonRes['general_index']),
    is_explosion : asT<String>(jsonRes['is_explosion']),
    original_img : asT<String>(jsonRes['original_img']),
    deposit : asT<String>(jsonRes['deposit']),
    is_live : asT<String>(jsonRes['is_live']),
    guide_article : asT<String>(jsonRes['guide_article']),
    tkurl : asT<String>(jsonRes['tkurl']),
    dx_rates : asT<String>(jsonRes['dx_rates']),
    taobao_image : asT<String>(jsonRes['taobao_image']),
    discount : asT<String>(jsonRes['discount']),
    sellernick : asT<String>(jsonRes['sellernick']),
    shopname : asT<String>(jsonRes['shopname']),
    couponendtime : asT<String>(jsonRes['couponendtime']),
    online_users : asT<String>(jsonRes['online_users']),
    me : asT<String>(jsonRes['me']),
    down_type : asT<String>(jsonRes['down_type']),
    son_category : asT<String>(jsonRes['son_category']),
    is_brand : asT<String>(jsonRes['is_brand']),
    userid : asT<String>(jsonRes['userid']),
    couponstarttime : asT<String>(jsonRes['couponstarttime']),
    coupon_condition : asT<String>(jsonRes['coupon_condition']),
    couponreceive2 : asT<String>(jsonRes['couponreceive2']),
    itemshorttitle : asT<String>(jsonRes['itemshorttitle']),
    todaycouponreceive : asT<String>(jsonRes['todaycouponreceive']),
    original_article : asT<String>(jsonRes['original_article']),
    deposit_deduct : asT<String>(jsonRes['deposit_deduct']),
  );

  String itempic_copy;
  String itemendprice;
  String todaysale;
  String itemprice;
  String itemtitle;
  String shoptype;
  String tktype;
  String fqcat;
  String tkrates;
  String cuntao;
  String tkmoney;
  String couponurl;
  String couponmoney;
  String itemsale2;
  String couponsurplus;
  String couponreceive;
  String couponnum;
  String itemid;
  String seller_id;
  String product_id;
  String itemdesc;
  String itemsale;
  String itempic;
  String seller_name;
  String activity_type;
  String videoid;
  String isquality;
  String start_time;
  String couponexplain;
  String is_shipping;
  String activityid;
  String report_status;
  String starttime;
  String end_time;
  String planlink;
  String shopid;
  String general_index;
  String is_explosion;
  String original_img;
  String deposit;
  String is_live;
  String guide_article;
  String tkurl;
  String dx_rates;
  String taobao_image;
  String discount;
  String sellernick;
  String shopname;
  String couponendtime;
  String online_users;
  String me;
  String down_type;
  String son_category;
  String is_brand;
  String userid;
  String couponstarttime;
  String coupon_condition;
  String couponreceive2;
  String itemshorttitle;
  String todaycouponreceive;
  String original_article;
  String deposit_deduct;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'itempic_copy': itempic_copy,
    'itemendprice': itemendprice,
    'todaysale': todaysale,
    'itemprice': itemprice,
    'itemtitle': itemtitle,
    'shoptype': shoptype,
    'tktype': tktype,
    'fqcat': fqcat,
    'tkrates': tkrates,
    'cuntao': cuntao,
    'tkmoney': tkmoney,
    'couponurl': couponurl,
    'couponmoney': couponmoney,
    'itemsale2': itemsale2,
    'couponsurplus': couponsurplus,
    'couponreceive': couponreceive,
    'couponnum': couponnum,
    'itemid': itemid,
    'seller_id': seller_id,
    'product_id': product_id,
    'itemdesc': itemdesc,
    'itemsale': itemsale,
    'itempic': itempic,
    'seller_name': seller_name,
    'activity_type': activity_type,
    'videoid': videoid,
    'isquality': isquality,
    'start_time': start_time,
    'couponexplain': couponexplain,
    'is_shipping': is_shipping,
    'activityid': activityid,
    'report_status': report_status,
    'starttime': starttime,
    'end_time': end_time,
    'planlink': planlink,
    'shopid': shopid,
    'general_index': general_index,
    'is_explosion': is_explosion,
    'original_img': original_img,
    'deposit': deposit,
    'is_live': is_live,
    'guide_article': guide_article,
    'tkurl': tkurl,
    'dx_rates': dx_rates,
    'taobao_image': taobao_image,
    'discount': discount,
    'sellernick': sellernick,
    'shopname': shopname,
    'couponendtime': couponendtime,
    'online_users': online_users,
    'me': me,
    'down_type': down_type,
    'son_category': son_category,
    'is_brand': is_brand,
    'userid': userid,
    'couponstarttime': couponstarttime,
    'coupon_condition': coupon_condition,
    'couponreceive2': couponreceive2,
    'itemshorttitle': itemshorttitle,
    'todaycouponreceive': todaycouponreceive,
    'original_article': original_article,
    'deposit_deduct': deposit_deduct,
  };

  @override
  String  toString() {
    return json.encode(this);
  }
}


class BottomFour {
  BottomFour({
    this.tag,
    this.title,
    this.router,
    this.tagtextColor,
    this.goods,
    this.tagBgColor,
  });


  factory BottomFour.fromJson(Map<String, dynamic> jsonRes){ if(jsonRes == null){return null;}
  final List<GoodsInfo> goods = jsonRes['goods'] is List ? <GoodsInfo>[]: null;
  if(goods!=null) {
    for (final dynamic item in jsonRes['goods']) { if (item != null) { goods.add(GoodsInfo.fromJson(asT<Map<String,dynamic>>(item)));  } }
  }


  return BottomFour(tag : asT<String>(jsonRes['tag']),
    title : asT<String>(jsonRes['title']),
    router : asT<String>(jsonRes['router']),
    tagtextColor : asT<String>(jsonRes['tagtextColor']),
    goods:goods,
    tagBgColor : asT<String>(jsonRes['tagBgColor']),
  );}

  String tag;
  String title;
  String router;
  String tagtextColor;
  List<GoodsInfo> goods;
  String tagBgColor;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'tag': tag,
    'title': title,
    'router': router,
    'tagtextColor': tagtextColor,
    'goods': goods,
    'tagBgColor': tagBgColor,
  };

  @override
  String  toString() {
    return json.encode(this);
  }
}



class BottomOne {
  BottomOne({
    this.tag,
    this.title,
    this.router,
    this.tagtextColor,
    this.goods,
    this.tagBgColor,
  });


  factory BottomOne.fromJson(Map<String, dynamic> jsonRes){ if(jsonRes == null){return null;}
  final List<GoodsInfo> goods = jsonRes['goods'] is List ? <GoodsInfo>[]: null;
  if(goods!=null) {
    for (final dynamic item in jsonRes['goods']) { if (item != null) { goods.add(GoodsInfo.fromJson(asT<Map<String,dynamic>>(item)));  } }
  }


  return BottomOne(tag : asT<String>(jsonRes['tag']),
    title : asT<String>(jsonRes['title']),
    router : asT<String>(jsonRes['router']),
    tagtextColor : asT<String>(jsonRes['tagtextColor']),
    goods:goods,
    tagBgColor : asT<String>(jsonRes['tagBgColor']),
  );}

  String tag;
  String title;
  String router;
  String tagtextColor;
  List<GoodsInfo> goods;
  String tagBgColor;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'tag': tag,
    'title': title,
    'router': router,
    'tagtextColor': tagtextColor,
    'goods': goods,
    'tagBgColor': tagBgColor,
  };

  @override
  String  toString() {
    return json.encode(this);
  }
}



class LeftTopOne {
  LeftTopOne({
    this.tag,
    this.title,
    this.router,
    this.tagtextColor,
    this.goods,
    this.tagBgColor,
  });


  factory LeftTopOne.fromJson(Map<String, dynamic> jsonRes){ if(jsonRes == null){return null;}
  final List<GoodsInfo> goods = jsonRes['goods'] is List ? <GoodsInfo>[]: null;
  if(goods!=null) {
    for (final dynamic item in jsonRes['goods']) { if (item != null) { goods.add(GoodsInfo.fromJson(asT<Map<String,dynamic>>(item)));  } }
  }


  return LeftTopOne(tag : asT<String>(jsonRes['tag']),
    title : asT<String>(jsonRes['title']),
    router : asT<String>(jsonRes['router']),
    tagtextColor : asT<String>(jsonRes['tagtextColor']),
    goods:goods,
    tagBgColor : asT<String>(jsonRes['tagBgColor']),
  );}

  String tag;
  String title;
  String router;
  String tagtextColor;
  List<GoodsInfo> goods;
  String tagBgColor;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'tag': tag,
    'title': title,
    'router': router,
    'tagtextColor': tagtextColor,
    'goods': goods,
    'tagBgColor': tagBgColor,
  };

  @override
  String  toString() {
    return json.encode(this);
  }
}



class RightTopOne {
  RightTopOne({
    this.tag,
    this.title,
    this.router,
    this.tagtextColor,
    this.goods,
    this.tagBgColor,
  });


  factory RightTopOne.fromJson(Map<String, dynamic> jsonRes){ if(jsonRes == null){return null;}
  final List<GoodsInfo> goods = jsonRes['goods'] is List ? <GoodsInfo>[]: null;
  if(goods!=null) {
    for (final dynamic item in jsonRes['goods']) { if (item != null) { goods.add(GoodsInfo.fromJson(asT<Map<String,dynamic>>(item)));  } }
  }


  return RightTopOne(tag : asT<String>(jsonRes['tag']),
    title : asT<String>(jsonRes['title']),
    router : asT<String>(jsonRes['router']),
    tagtextColor : asT<String>(jsonRes['tagtextColor']),
    goods:goods,
    tagBgColor : asT<String>(jsonRes['tagBgColor']),
  );}

  String tag;
  String title;
  String router;
  String tagtextColor;
  List<GoodsInfo> goods;
  String tagBgColor;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'tag': tag,
    'title': title,
    'router': router,
    'tagtextColor': tagtextColor,
    'goods': goods,
    'tagBgColor': tagBgColor,
  };

  @override
  String  toString() {
    return json.encode(this);
  }
}



class BottomTwo {
  BottomTwo({
    this.tag,
    this.title,
    this.router,
    this.tagtextColor,
    this.goods,
    this.tagBgColor,
  });


  factory BottomTwo.fromJson(Map<String, dynamic> jsonRes){ if(jsonRes == null){return null;}
  final List<GoodsInfo> goods = jsonRes['goods'] is List ? <GoodsInfo>[]: null;
  if(goods!=null) {
    for (final dynamic item in jsonRes['goods']) { if (item != null) { goods.add(GoodsInfo.fromJson(asT<Map<String,dynamic>>(item)));  } }
  }


  return BottomTwo(tag : asT<String>(jsonRes['tag']),
    title : asT<String>(jsonRes['title']),
    router : asT<String>(jsonRes['router']),
    tagtextColor : asT<String>(jsonRes['tagtextColor']),
    goods:goods,
    tagBgColor : asT<String>(jsonRes['tagBgColor']),
  );}

  String tag;
  String title;
  String router;
  String tagtextColor;
  List<GoodsInfo> goods;
  String tagBgColor;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'tag': tag,
    'title': title,
    'router': router,
    'tagtextColor': tagtextColor,
    'goods': goods,
    'tagBgColor': tagBgColor,
  };

  @override
  String  toString() {
    return json.encode(this);
  }
}




