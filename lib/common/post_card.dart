import 'package:flutter/material.dart';
import '../modals/IndexData.dart';

class PostCard extends StatelessWidget {
  // 博客数据
  final Dtolist dtolist;

  PostCard(this.dtolist);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.white54),
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
//          头像+昵称+时间
          Container(
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            child: Row(
              children: <Widget>[
                //标题+昵称
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        dtolist.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    //作者
                    Text(
                      dtolist.author,
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                )),

                //头像
                CircleAvatar(
                  backgroundImage: NetworkImage(dtolist.authorHeader),
                  radius: 20.0,
                  backgroundColor: Colors.white,
                )
              ],
            ),
          ),

          //简介
          new Container(
            
            alignment: AlignmentDirectional.topStart,
            padding: EdgeInsets.all(32.0),
            child: new Text(
              dtolist.content,
              softWrap: true,
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}
