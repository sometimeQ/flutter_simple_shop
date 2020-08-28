import 'package:demo1/provider/ddq_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './app_bar_widget.dart';
import './goods_item.dart';
import '../../modals/ddq_modal.dart';
import '../../widgets/up_down_btn_widget.dart';
import './sliver_app_bar_delegate.dart';
import '../../widgets/ddq_times_widget.dart';

class DdqIndexHome extends StatefulWidget {
  @override
  _DdqIndexHomeState createState() => _DdqIndexHomeState();
}

class _DdqIndexHomeState extends State<DdqIndexHome> {
  DdqProvider ddqProvider;
  int cur;

  @override
  Widget build(BuildContext context) {
    return Consumer<DdqProvider>(
        builder: (context, ddq, _) => Scaffold(
            appBar: appBar,
            body: CustomScrollView(
              slivers: <Widget>[
                _buildSliverAppBar(),
                _buildTimesList(),
                _buildSpace(),
                _buildList(),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                      maxHeight: ScreenUtil().setHeight(150),
                      minHeight: ScreenUtil().setHeight(150),
                      child: Container(
                        child: Center(
                          child: Text("我是有底线的~~"),
                        ),
                      )),
                )
              ],
            )));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    DdqProvider ddqProvider = Provider.of<DdqProvider>(context);
    if (this.ddqProvider != ddqProvider) {
      this.ddqProvider = ddqProvider;
      ddqProvider.loadData();
    }
  }

//  List<Widget> _buildTimes() {
//    List<Widget> list = [];
//    List<RoundsList> times = this.ddqProvider.roundsList;
//    for (var timeItem in times) {
//      //上层文字
//      String upText =
//          "${timeItem.ddqTime.hour.toString().padLeft(2, "0")}:${timeItem.ddqTime.minute.toString().padLeft(2, "0")}";
//
//      //下层文字
//      int state = timeItem.status;
//      String downText = "已开抢";
//      if (state == 1) {
//        downText = "正在疯抢";
//      }
//      if (state == 2) {
//        downText = "未开始";
//      }
//
//      //选中
//      bool isCur = this.ddqProvider.ddqTime == timeItem.ddqTime;
//
//      list.add(InkWell(
//        onTap: () {
//          this.ddqProvider.timeChange(timeItem.ddqTime, timeItem.status);
//        },
//        child:
//            UpDownBtnWidget(upText: upText, downText: downText, isCur: isCur),
//      ));
//    }
//    return list;
//  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: ScreenUtil().setHeight(300),
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        background: Image.asset("assets/images/ddq.jpg", fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildTimesList() {
    return SliverPersistentHeader(
        floating: true,
        pinned: true,
        delegate: SliverAppBarDelegate(
            minHeight: ScreenUtil().setHeight(220),
            maxHeight: ScreenUtil().setHeight(220),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30), horizontal: ScreenUtil().setWidth(30)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.white70))),
              child: DdqTimesWidget(
                timesList: ddqProvider.roundsList,
                ddqProvider: ddqProvider,
              ),
            )));
  }

  Widget _buildSpace() {
    return SliverPersistentHeader(
      delegate: SliverAppBarDelegate(
          minHeight: ScreenUtil().setHeight(30),
          maxHeight: ScreenUtil().setHeight(30),
          child: Container()),
    );
  }

  Widget _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return GoodsItem(
        goodsItem: this.ddqProvider.goodsList[index],
        state: this.ddqProvider.status,
      );
    }, childCount: this.ddqProvider.goodsList.length));
  }
}
