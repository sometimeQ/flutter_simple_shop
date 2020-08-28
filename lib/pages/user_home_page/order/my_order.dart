import 'package:common_utils/common_utils.dart';
import 'package:demo1/modals/order_list_model.dart';
import 'package:demo1/widgets/loading_more_list_indicator.dart';
import 'package:demo1/widgets/pullto_refresh_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import '../../../repository/order_respository.dart';

class MyOrderHomePage extends StatefulWidget {

  String stype; // 审核类型

  MyOrderHomePage({this.stype});

  @override
  _MyOrderHomePageState createState() => _MyOrderHomePageState();
}

class _MyOrderHomePageState extends State<MyOrderHomePage> {

  OrderRespository orderRespository = OrderRespository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("全部订单"),
        centerTitle: true,
      ),
      body: PullToRefreshNotification(
          pullBackOnRefresh: false,
          maxDragOffset: 80.0,
          armedDragUpCancel: false,
          onRefresh: () async {
          await orderRespository.refresh(true);
          return true;
        },
          child: LoadingMoreCustomScrollView(
            slivers: <Widget>[

              PullToRefreshContainer(buildPulltoRefreshHeader),

              LoadingMoreSliverList(
                  SliverListConfig<OrderAuditObject>(

                    itemBuilder: (c,item,index){
                      String createTimeStr = DateUtil.formatDateMs(int.parse(item.createTime),format: "yyyy-MM-dd HH:mm:ss");
                      String stateTip = "等待审核";
                      Color stateTipColor = Colors.black;
                      Icon stateIcon = Icon(Icons.info_outline,color: stateTipColor,);
                      if(item.stype==1){
                        stateTip = "审核通过";
                        stateTipColor = Colors.green;
                        Icon stateIcon = Icon(Icons.check,color: stateTipColor,);
                      }else if(item.stype==2){
                        stateTip = "审核失效";
                        stateTipColor = Colors.deepOrange;
                        Icon stateIcon = Icon(Icons.clear,color: stateTipColor,);
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50),vertical: ScreenUtil().setHeight(30)),
                        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        decoration: BoxDecoration(
                          color:Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("订单编号:${item.orderid}"),
                                Row(
                                  children: <Widget>[
                                    stateIcon,
                                    SizedBox(width: ScreenUtil().setWidth(20),),
                                    Text("${stateTip}",style: TextStyle(color: stateTipColor),),
                                  ],
                                )
                              ],
                            ),
                            Text("提交时间:${createTimeStr}"),
                          ],
                        ),
                      );
                    },
                    sourceList: orderRespository,
                    indicatorBuilder: (context, state) {
                      return LoadingMoreListCostumIndicator(state, isSliver: true);
                    },
                  ),
              )
            ],
          ), ),
    );
  }

}
