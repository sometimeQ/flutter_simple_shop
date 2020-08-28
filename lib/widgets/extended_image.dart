import 'package:flustars/flustars.dart' hide ScreenUtil;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/screenutil.dart';
import '../util/image_util.dart';

// 图像扩展组件
class ExtendedImageWidget extends StatelessWidget {
  String src;
  double height;
  double width;
  BorderRadius radius;
  BoxFit fit;
  bool knowSize;

  ExtendedImageWidget({
    this.src,
    this.height,
    this.width,
    this.radius: BorderRadius.zero,
    this.fit: BoxFit.fill,
    this.knowSize: true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: buildExtendedImage(w: width, h: height));
  }

  Widget buildExtendedImage({double w, double h}) {
    Widget image = Stack(
      children: <Widget>[
        ExtendedImage.network(
          MImageUtils.magesProcessor(src),
          fit: fit,
          borderRadius: radius,
          shape: BoxShape.rectangle,
          clearMemoryCacheWhenDispose: true,
          cache: true,
          enableLoadState: true,
          loadStateChanged: (ExtendedImageState state) {
            if (state.extendedImageLoadState == LoadState.loading) {
              Widget loadingWidget = Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(w),
                height: ScreenUtil().setHeight(h),
                color: Colors.grey.withOpacity(0.4),
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                ),
              );

              if (!knowSize) {
                loadingWidget = AspectRatio(
                  aspectRatio: 1.0,
                  child: loadingWidget,
                );
              }

              return loadingWidget;
            }

            if (state.extendedImageLoadState == LoadState.failed) {
              return Container(
                width: ScreenUtil().setWidth(w ?? width),
                height: ScreenUtil().setHeight(h ?? height),
                child: Center(
                  child: Column(children: <Widget>[
                    Text("图片加载失败"),
                    InkWell(
                      onTap: () {
                        state.reLoadImage();
                      },
                      child: Text("重新加载"),
                    )
                  ]),
                ),
              );
            }

            if (state.extendedImageLoadState == LoadState.completed) {
              Size isize = Size(state.extendedImageInfo.image.width.toDouble(),
                  state.extendedImageInfo.image.height.toDouble());

              Widget wight =  ExtendedRawImage(
                fit: fit,
                image: state.extendedImageInfo?.image,
                height: knowSize ?  ScreenUtil().setHeight(height) : isize.height,
                width: knowSize ? ScreenUtil().setWidth(width) : isize.width,
              );

//              print("src:${src}的图片尺寸为:\n${isize.width}:${isize.height}");

              return knowSize ? wight : AspectRatio(
                aspectRatio: isize.width / isize.height,
                child: wight,
              );
            }
            return null;
          },
        )
      ],
    );

    return image;
  }
}
