import 'dart:ui';
import 'package:demo1/modals/ddq_modal.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../fluro/NavigatorUtil.dart';
import '../../provider/ddq_provider.dart';
import './index_layout.dart';

// 钉钉抢
class DDQWidget extends StatefulWidget {
  @override
  _DDQWidgetState createState() => _DDQWidgetState();
}

class _DDQWidgetState extends State<DDQWidget> {
  final GlobalKey globalKey = GlobalKey();
  DdqProvider ddqProvider;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<DdqProvider>(
      builder: (context, ddqProvider, _) => IndexPublicLayout(
        child: Container(
          padding: EdgeInsets.symmetric( horizontal: ScreenUtil().setWidth(50),vertical: ScreenUtil().setHeight(25)),
          height: ScreenUtil().setHeight(900),
          child: Column(
            children: <Widget>[
              _buildWidgetTitle(height: 100),
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              _buildWidgetGoosList(),
            ],
          ),
        ),
      ),
    );
  }

  /// 标题version2
  Widget _buildWidgetTitle({String title,double height}) {
    String showTitle = title ?? "限时抢购";
    return Container(
      height: ScreenUtil().setHeight(height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              showTitle,
              style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(70)),
            ),
          ),InkWell(
            onTap: (){
              NavigatorUtil.goTODdqPage(context);
            },
              child: Icon(Icons.chevron_right,color: Colors.grey,),
          )
        ],
      ),
    );
  }

  /// 商品列表version2
  Widget _buildWidgetGoosList() {
    List<DdqGoodsListItem> list = ddqProvider.goodsList;
    if (list.length >= 3) {
      return Container(
        height: ScreenUtil().setHeight(700),
        child: Row(
          children: <Widget>[
            _mimiGoodsCard(
                list[0].mainPic,
                list[0].actualPrice.toString(),
                list[0].originalPrice.toString(),
                list[0].monthSales.toString(),
                list[0].dtitle),
            SizedBox(width: ScreenUtil().setWidth(50)),
            _mimiGoodsCard(
                list[1].mainPic,
                list[1].actualPrice.toString(),
                list[1].originalPrice.toString(),
                list[1].monthSales.toString(),
                list[1].dtitle),
            SizedBox(width: ScreenUtil().setWidth(50)),
            _mimiGoodsCard(
                list[2].mainPic,
                list[2].actualPrice.toString(),
                list[2].originalPrice.toString(),
                list[2].monthSales.toString(),
                list[2].dtitle),
          ],
        ),
      );
    }
    return Row(
      children: <Widget>[
      ],
    );
  }


  // 商品卡片布局
  Widget _mimiGoodsCard(
      String src, String price, String orginPrice, String xl, String title) {
    return Container(
      width: ScreenUtil().setWidth(380),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          ExtendedImageWidget(
            src: src,
            height: 400,
            width: 370,
            radius: BorderRadius.all(
               Radius.circular(10)),
          ),
          SizedBox(height: ScreenUtil().setHeight(50)),
          Container(
            height: ScreenUtil().setHeight(130),
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(42)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          Container(
            height: ScreenUtil().setHeight(100),
            child: Row(
              verticalDirection: VerticalDirection.up,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    '￥${price}',
                    style: TextStyle(
                        color: Colors.red, fontSize: ScreenUtil().setSp(50)),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(width: ScreenUtil().setWidth(20)),
                Expanded(
                  child: Text(
                    "￥${orginPrice}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: ScreenUtil().setSp(45),
                        decoration: TextDecoration.lineThrough),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    DdqProvider ddqProvider = Provider.of<DdqProvider>(context);
    if (this.ddqProvider != ddqProvider) {
      this.ddqProvider = ddqProvider;
      await Future.delayed(Duration(seconds: 1), () {
        ddqProvider.loadData();
      });

      setState(() {
        isLoading = false;
      });
    }
  }
}
