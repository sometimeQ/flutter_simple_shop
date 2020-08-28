// To parse this JSON data, do
//
//     final hdkGoodsDetailModel = hdkGoodsDetailModelFromJson(jsonString);

import 'dart:convert';

HdkGoodsDetailModel hdkGoodsDetailModelFromJson(String str) => HdkGoodsDetailModel.fromJson(json.decode(str));

String hdkGoodsDetailModelToJson(HdkGoodsDetailModel data) => json.encode(data.toJson());

class HdkGoodsDetailModel {
  HdkGoodsDetailModel({
    this.images,
    this.video,
    this.info,
  });

  List<String> images;
  List<Video> video;
  Info info;

  factory HdkGoodsDetailModel.fromJson(Map<String, dynamic> json) => HdkGoodsDetailModel(
    images: List<String>.from(json["images"].map((x) => x)),
    video: List<Video>.from(json["video"].map((x) => Video.fromJson(x))),
    info: Info.fromJson(json["info"])
  );

  Map<String, dynamic> toJson() => {
    "images": List<dynamic>.from(images.map((x) => x)),
    "video": List<dynamic>.from(video.map((x) => x.toJson())),
    "info": info.toJson()
  };
}

class Video {
  Video({
    this.itemid,
    this.douyinCid,
    this.dynamicImage,
    this.videoUrl,
    this.itemidTitle,
    this.firstFrame,
    this.douyinEmceeFans,
    this.videoForwardCount,
    this.videoCommentCount,
    this.videoShareCount,
    this.videoLikeCount,
  });

  String itemid;
  String douyinCid;
  String dynamicImage;
  String videoUrl;
  String itemidTitle;
  String firstFrame;
  String douyinEmceeFans;
  String videoForwardCount;
  String videoCommentCount;
  String videoShareCount;
  String videoLikeCount;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    itemid: json["itemid"],
    douyinCid: json["douyin_cid"],
    dynamicImage: json["dynamic_image"],
    videoUrl: json["video_url"],
    itemidTitle: json["itemid_title"],
    firstFrame: json["first_frame"],
    douyinEmceeFans: json["douyin_emcee_fans"],
    videoForwardCount: json["video_forward_count"],
    videoCommentCount: json["video_comment_count"],
    videoShareCount: json["video_share_count"],
    videoLikeCount: json["video_like_count"],
  );

  Map<String, dynamic> toJson() => {
    "itemid": itemid,
    "douyin_cid": douyinCid,
    "dynamic_image": dynamicImage,
    "video_url": videoUrl,
    "itemid_title": itemidTitle,
    "first_frame": firstFrame,
    "douyin_emcee_fans": douyinEmceeFans,
    "video_forward_count": videoForwardCount,
    "video_comment_count": videoCommentCount,
    "video_share_count": videoShareCount,
    "video_like_count": videoLikeCount,
  };
}


class Info {
  String userid;
  String tkmoney;
  String couponmoney;
  String tktype;
  String starttime;
  String startTime;
  String couponendtime;
  String productId;
  String itemtitle;
  String itempic;
  String couponexplain;
  String isquality;
  String isBrand;
  String isLive;
  String generalIndex;
  String sellerName;
  String sellernick;
  String shopname;
  String onlineUsers;
  String originalImg;
  String planlink;
  String reportStatus;
  String activityType;
  String itempicCopy;
  String shoptype;
  String itemprice;
  String videoid;
  String todaysale;
  String couponnum;
  String discount;
  String itemendprice;
  String itemdesc;
  String itemsale;
  String couponsurplus;
  String cuntao;
  String sellerId;
  String fqcat;
  String couponreceive;
  String couponurl;
  String endTime;
  String guideArticle;
  String itemid;
  String itemsale2;
  String tkrates;
  String tkurl;
  String activityid;
  String sonCategory;
  String taobaoImage;
  String downType;
  String dxRates;
  String shopid;
  String deposit;
  String isExplosion;
  String me;
  String isShipping;
  String itemshorttitle;
  String couponreceive2;
  String couponstarttime;
  String couponCondition;
  String originalArticle;
  String todaycouponreceive;
  String depositDeduct;

  Info(
      {this.userid,
        this.tkmoney,
        this.couponmoney,
        this.tktype,
        this.starttime,
        this.startTime,
        this.couponendtime,
        this.productId,
        this.itemtitle,
        this.itempic,
        this.couponexplain,
        this.isquality,
        this.isBrand,
        this.isLive,
        this.generalIndex,
        this.sellerName,
        this.sellernick,
        this.shopname,
        this.onlineUsers,
        this.originalImg,
        this.planlink,
        this.reportStatus,
        this.activityType,
        this.itempicCopy,
        this.shoptype,
        this.itemprice,
        this.videoid,
        this.todaysale,
        this.couponnum,
        this.discount,
        this.itemendprice,
        this.itemdesc,
        this.itemsale,
        this.couponsurplus,
        this.cuntao,
        this.sellerId,
        this.fqcat,
        this.couponreceive,
        this.couponurl,
        this.endTime,
        this.guideArticle,
        this.itemid,
        this.itemsale2,
        this.tkrates,
        this.tkurl,
        this.activityid,
        this.sonCategory,
        this.taobaoImage,
        this.downType,
        this.dxRates,
        this.shopid,
        this.deposit,
        this.isExplosion,
        this.me,
        this.isShipping,
        this.itemshorttitle,
        this.couponreceive2,
        this.couponstarttime,
        this.couponCondition,
        this.originalArticle,
        this.todaycouponreceive,
        this.depositDeduct});

  Info.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    tkmoney = json['tkmoney'];
    couponmoney = json['couponmoney'];
    tktype = json['tktype'];
    starttime = json['starttime'];
    startTime = json['start_time'];
    couponendtime = json['couponendtime'];
    productId = json['product_id'];
    itemtitle = json['itemtitle'];
    itempic = json['itempic'];
    couponexplain = json['couponexplain'];
    isquality = json['isquality'];
    isBrand = json['is_brand'];
    isLive = json['is_live'];
    generalIndex = json['general_index'];
    sellerName = json['seller_name'];
    sellernick = json['sellernick'];
    shopname = json['shopname'];
    onlineUsers = json['online_users'];
    originalImg = json['original_img'];
    planlink = json['planlink'];
    reportStatus = json['report_status'];
    activityType = json['activity_type'];
    itempicCopy = json['itempic_copy'];
    shoptype = json['shoptype'];
    itemprice = json['itemprice'];
    videoid = json['videoid'];
    todaysale = json['todaysale'];
    couponnum = json['couponnum'];
    discount = json['discount'];
    itemendprice = json['itemendprice'];
    itemdesc = json['itemdesc'];
    itemsale = json['itemsale'];
    couponsurplus = json['couponsurplus'];
    cuntao = json['cuntao'];
    sellerId = json['seller_id'];
    fqcat = json['fqcat'];
    couponreceive = json['couponreceive'];
    couponurl = json['couponurl'];
    endTime = json['end_time'];
    guideArticle = json['guide_article'];
    itemid = json['itemid'];
    itemsale2 = json['itemsale2'];
    tkrates = json['tkrates'];
    tkurl = json['tkurl'];
    activityid = json['activityid'];
    sonCategory = json['son_category'];
    taobaoImage = json['taobao_image'];
    downType = json['down_type'];
    dxRates = json['dx_rates'];
    shopid = json['shopid'];
    deposit = json['deposit'];
    isExplosion = json['is_explosion'];
    me = json['me'];
    isShipping = json['is_shipping'];
    itemshorttitle = json['itemshorttitle'];
    couponreceive2 = json['couponreceive2'];
    couponstarttime = json['couponstarttime'];
    couponCondition = json['coupon_condition'];
    originalArticle = json['original_article'];
    todaycouponreceive = json['todaycouponreceive'];
    depositDeduct = json['deposit_deduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['tkmoney'] = this.tkmoney;
    data['couponmoney'] = this.couponmoney;
    data['tktype'] = this.tktype;
    data['starttime'] = this.starttime;
    data['start_time'] = this.startTime;
    data['couponendtime'] = this.couponendtime;
    data['product_id'] = this.productId;
    data['itemtitle'] = this.itemtitle;
    data['itempic'] = this.itempic;
    data['couponexplain'] = this.couponexplain;
    data['isquality'] = this.isquality;
    data['is_brand'] = this.isBrand;
    data['is_live'] = this.isLive;
    data['general_index'] = this.generalIndex;
    data['seller_name'] = this.sellerName;
    data['sellernick'] = this.sellernick;
    data['shopname'] = this.shopname;
    data['online_users'] = this.onlineUsers;
    data['original_img'] = this.originalImg;
    data['planlink'] = this.planlink;
    data['report_status'] = this.reportStatus;
    data['activity_type'] = this.activityType;
    data['itempic_copy'] = this.itempicCopy;
    data['shoptype'] = this.shoptype;
    data['itemprice'] = this.itemprice;
    data['videoid'] = this.videoid;
    data['todaysale'] = this.todaysale;
    data['couponnum'] = this.couponnum;
    data['discount'] = this.discount;
    data['itemendprice'] = this.itemendprice;
    data['itemdesc'] = this.itemdesc;
    data['itemsale'] = this.itemsale;
    data['couponsurplus'] = this.couponsurplus;
    data['cuntao'] = this.cuntao;
    data['seller_id'] = this.sellerId;
    data['fqcat'] = this.fqcat;
    data['couponreceive'] = this.couponreceive;
    data['couponurl'] = this.couponurl;
    data['end_time'] = this.endTime;
    data['guide_article'] = this.guideArticle;
    data['itemid'] = this.itemid;
    data['itemsale2'] = this.itemsale2;
    data['tkrates'] = this.tkrates;
    data['tkurl'] = this.tkurl;
    data['activityid'] = this.activityid;
    data['son_category'] = this.sonCategory;
    data['taobao_image'] = this.taobaoImage;
    data['down_type'] = this.downType;
    data['dx_rates'] = this.dxRates;
    data['shopid'] = this.shopid;
    data['deposit'] = this.deposit;
    data['is_explosion'] = this.isExplosion;
    data['me'] = this.me;
    data['is_shipping'] = this.isShipping;
    data['itemshorttitle'] = this.itemshorttitle;
    data['couponreceive2'] = this.couponreceive2;
    data['couponstarttime'] = this.couponstarttime;
    data['coupon_condition'] = this.couponCondition;
    data['original_article'] = this.originalArticle;
    data['todaycouponreceive'] = this.todaycouponreceive;
    data['deposit_deduct'] = this.depositDeduct;
    return data;
  }
}

