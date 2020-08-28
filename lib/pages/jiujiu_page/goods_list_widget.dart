import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../modals/NineGoodsData.dart';
import './goods_item_widget.dart';

class GoodsListWidget extends StatelessWidget {

  List<NineGoodsItem> list;
  bool isInitLoading;
  GoodsListWidget({@required this.list,this.isInitLoading});

  @override
  Widget build(BuildContext context) {
    return isInitLoading? Container(
      height: ScreenUtil().setHeight(500),
      width: ScreenUtil().setWidth(1440),
      child: Center(
        child: Image.asset("assets/images/loading.gif"),
      ),
    ) : Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context,index){
          return GoodsItemWidget(goodsItem: list[index]);
        },
      ),
    );
  }
}
