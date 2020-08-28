import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './pull_to_refresh_widget.dart';


class RefreshAndLoadMore extends StatelessWidget {

  dynamic refreshFun;
  dynamic loadMoreFun;
  RefreshController controller;
  dynamic listViewCntroller;
  List<Widget> children;

  RefreshAndLoadMore({this.refreshFun, this.loadMoreFun, this.children,this.controller,this.listViewCntroller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SmartRefresher(
        controller: controller,
        onRefresh: refreshFun,
        onLoading: loadMoreFun,
        enablePullDown: true,
        enablePullUp: true,
        physics: ClampingScrollPhysics(),
        header: MaterialClassicHeader(),
        footer: PullToRefreshWidgetFoot(),
        child: ListView(
          controller: listViewCntroller??null,
          physics: ClampingScrollPhysics(),
          children: children,
        ),
      ),
    );
  }
}
