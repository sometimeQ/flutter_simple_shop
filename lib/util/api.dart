class Api {
  //------------------------------------淘客相关--------------------------------------------
  static const String API_INDEX_DATA = 'articles'; // 首页数据
  static const String API_DETAIL_DATA = 'findPostDetail'; // 文章详情数据
  static const String API_CAROUSEL_DATA = 'carousel'; // 轮播图数据

  static const String API_DTK_GET_RANK_LIST = 'dtk/get-ranking-list'; // 大淘客榜单数据
  static const String API_DTK_GET_GOODS_DETAIL_INFO =
      'dtk/get-goods-details'; // 大淘客商品详情
  static const String API_DTK_GET_GOODS_LIST = 'dtk/get-goods-list'; // 商品库
  static const String API_DTK_GET_PRIVILEGE =
      'dtk/get-privilege-link'; // 获取优惠券信息
  static const String API_DTK_GET_NINE_GOODS =
      "dtk/get-nine-goods"; // 获取9.9包邮商品
  static const String API_DTK_GET_CATEGORYS = "dtk/get-category"; //获取大淘客超级分类

  static const String API_DTK_GET_DDQ = "dtk/get-ddq"; //钉钉抢

  //------------------------------------用户相关--------------------------------------------
  static const String API_USER = "wechat/user"; //用户通用接口
  static const String API_FAVORITE = "favorites"; // 用户收藏商品接口

  ///订单顶级接口值为: dtk/order
  static const String API_ORDER = "dtk/order"; // 用户的大淘客订单

  /// 好单库相关api
  static const String API_HDK_DETAIL = 'hdk/detail'; // 商品详情接口

  // 店铺信息api
static const String API_GET_SHOP_INFO = "hdk/shop_info";

//公共api
static const String API_INDEX_GRID_SPECIAL = "hdk/get-index-grid-special";
}
