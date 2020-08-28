import 'package:demo1/provider/goods_detail_provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/extended_image.dart';

class SwiperWidget extends StatelessWidget {
  String images;
  GoodsDetailProvider goodsDetailProvider;
  SwiperWidget({this.images,this.goodsDetailProvider});

  List<String> imgArr;

  @override
  Widget build(BuildContext context) {
    if (images != null && images != "") {
      imgArr = images.split(",");
      return Stack(
        children: <Widget>[
          Container(
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return ExtendedImageWidget(
                  height: 1440,
                  width: 1440,
                  fit: BoxFit.cover,
                  src: imgArr[index],
                );
              },
              itemCount: imgArr.length,
              pagination: new SwiperPagination(),
            ),
            width: ScreenUtil().setWidth(1440),
            height: ScreenUtil().setHeight(1440),
          ),

          // 返回按钮
          Positioned(
              top: ScreenUtil().setHeight(120),
              left: ScreenUtil().setWidth(80),
              child: ClipOval(
                child: Container(
                    width: ScreenUtil().setWidth(150),
                    height: ScreenUtil().setHeight(150),
                    decoration: BoxDecoration(
                      color: Colors.black26.withOpacity(0.8),
                    ),
                    child: Center(
                        child: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: ScreenUtil().setSp(80),
                            ),
                            onPressed: () {
                              goodsDetailProvider.setNullInfo();
                              Navigator.pop(context);
                            }))),
              ))
        ],
      );
    }
    return Container();
  }

  ExtendedImage buildExtendedImage(int index) {
    return ExtendedImage.network(
      imgArr[index],
      fit: BoxFit.fill,
      cache: true,
      border: Border.all(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );
  }
}
