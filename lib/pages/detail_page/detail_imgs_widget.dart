import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/detail_simple_bborder_button.dart';

class DetailImagesWidget extends StatelessWidget {
  String images;

  DetailImagesWidget({this.images});

  @override
  Widget build(BuildContext context) {
    var imgs = _bulidImagesList();
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10, bottom: 10.0),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          // 文字
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DetailSimpleBorderButton(text: "详情", is_current: true),
                DetailSimpleBorderButton(text: "推荐", is_current: false)
              ],
            ),
          ),
          imgs != null
              ? Column(
                  children: imgs,
                )
              : Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text("暂无图文"),
                  )),
          Container(height: ScreenUtil().setHeight(200),)
        ],
      ),
    );
  }

  List<Widget> _bulidImagesList() {
    List<Widget> imagesWidget = [];
    if (images != "" && images != null) {
      List imagesArr = images.split(",");
      for (var item in imagesArr) {
        bool hasHttpHead = item.toString().contains("https:");
        if (!hasHttpHead) {
          item = "https:${item}";
        }
        imagesWidget.add(ExtendedImage.network(
          item,
          fit: BoxFit.fill,
          cache: true,
          border: Border.all(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          //cancelToken: cancellationToken,
        ));
      }
      return imagesWidget;
    }
  }
}
