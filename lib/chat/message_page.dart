import 'package:flutter/material.dart';
import './message_data.dart';
import './message_item.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //构造列表
      body: ListView.builder(
        itemCount: messageData.length,
        itemBuilder: (BuildContext context,int index){
          return new MessageItem(messageData[index]);
        },
      ),
    );
  }
}
