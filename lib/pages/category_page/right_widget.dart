import 'package:demo1/widgets/extended_image.dart';
import 'package:flutter/material.dart';
import '../../modals/dtkCategorys.dart';
import '../../fluro/NavigatorUtil.dart';

class RightWidgetItme extends StatelessWidget {

  Subcategory item;
  String cid;
  RightWidgetItme({this.item,this.cid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        NavigatorUtil.gotoGoodslistPage(context,subcid: item.subcid.toString(),title:item.subcname,cids: cid);
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            ExtendedImageWidget(src: item.scpic,width: 200,height: 200,),
            Text(item.subcname)
          ],
        ),
      ),
    );
  }
}
