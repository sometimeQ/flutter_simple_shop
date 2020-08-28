import 'package:flutter/material.dart';
class IndexStickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  EdgeInsets padding;
  final TabBar child;
  Color color;
  IndexStickyTabBarDelegate({@required this.child,this.color,this.padding});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: padding??EdgeInsets.zero,
      color:color!=null ? color : Colors.transparent,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}