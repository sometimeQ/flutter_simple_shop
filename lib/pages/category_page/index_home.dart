import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modals/dtkCategorys.dart';
import '../../provider/category_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './left_widget.dart';
import './right_widget.dart';

class CategoryIndexPage extends StatefulWidget {
  @override
  _CategoryIndexPageState createState() => _CategoryIndexPageState();
}

class _CategoryIndexPageState extends State<CategoryIndexPage> {
  CategoryProvider categoryProvider;

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, _) => Container(
          width: MediaQuery.of(context).size.width,
          child: categoryProvider.categorys.length != 0
              ? Row(
                  children: <Widget>[
                    //左侧
                    Container(
                      width: ScreenUtil().setWidth(300),
                      color: Color.fromRGBO(248, 248, 248, 1.0),
                      child: ListView.builder(
                          itemCount: categoryProvider.categorys.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                              child: LeftWidgetItem(
                                  item: categoryProvider.categorys[index],
                                  is_current: current == index),
                            );
                          }),
                    ),

                    //右侧
                    Expanded(
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                _buildTitle(),
                                GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 125,
                                            mainAxisSpacing: 10.0,
                                            crossAxisSpacing: 10.0),
                                    itemCount: categoryProvider
                                        .categorys[current]
                                        .subcategories
                                        .length,
                                    itemBuilder: (context, s_index) {
                                      return RightWidgetItme(
                                          cid: categoryProvider
                                              .categorys[current].cid
                                              .toString(),
                                          item: categoryProvider
                                              .categorys[current]
                                              .subcategories[s_index]);
                                    }),
                              ],
                            ),
                          )),
                    )
                  ],
                )
              : Container()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    if (this.categoryProvider != categoryProvider) {
      this.categoryProvider = categoryProvider;
      //  转到在pages/index_page/index_home 调用
//      categoryProvider.loadDtkCategoryDatas(context);
    }
  }

  Widget _buildTitle() {
    return Container(
      height: ScreenUtil().setHeight(150),
      alignment: Alignment.centerLeft,
      child: Text(
        this.categoryProvider.categorys[current].cname,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: ScreenUtil().setSp(60),
            color: Colors.black),
      ),
    );
  }
}
