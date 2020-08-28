import 'package:demo1/provider/carousel_provider.dart';
import 'package:demo1/util/image_util.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import './index_layout.dart';
import '../../modals/carouselData.dart';

// 首页轮播图
class IndexTopSwiper extends StatelessWidget {
  List<Datum> datum;
  int height;
  CarouselProviderModal carouselProviderModal;

  IndexTopSwiper({this.datum, this.carouselProviderModal,this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(height),// 430
      padding: EdgeInsets.only(left: 10, right: 10),
      child: IndexPublicLayout(
        transparencyBg: true,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Swiper(
          autoplay: datum.isNotEmpty,
          duration: 1000,
          loop: true,
//          viewportFraction: 0.8,
//          scale: 0.9,

          onTap: (index) async {
            if (await canLaunch(datum[index].url)) {
              await launch(datum[index].url);
            } else {
              print("首页轮播图跳转网址失败");
            }
          },
          onIndexChanged: (index) {
            Future.delayed(Duration(seconds: 0), () {
              carouselProviderModal.onChange(index);
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return ExtendedImageWidget(
                src:datum[index].src,
              width: 1340,
              height: height.toDouble(),
              radius: BorderRadius.all(Radius.circular(10.0)),
            );
          },
          itemCount: datum.length,
          pagination: new SwiperPagination(),
        ),
      ),
    );
  }

  Color getColor(String rgb) {
    List<String> colorsRgb = rgb.split(",");
    return Color.fromRGBO(int.parse(colorsRgb[0]), int.parse(colorsRgb[1]),
        int.parse(colorsRgb[2]), 1);
  }
}
