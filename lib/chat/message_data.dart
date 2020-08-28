class MessageData {
  //头像
  String avatar;

  //主标题
  String title;

//子标题
  String subTitle;

//消息时间
  DateTime time;

//消息类型
  MessageType type;

  MessageData(this.avatar, this.title, this.subTitle, this.time, this.type);
}

//消息类型枚举
enum MessageType {
  //系统消息
  SYSTEM,
  //公共消息
  PUBLIC,
  //私聊
  CHAT,
  //群聊
  GROUP
}

List<MessageData> messageData = [
  new MessageData('http://picbed.demo.saintic.com/static/upload/huang/2020/03/26/15851851917744307.jpg', '点点', '哈哈哈', new DateTime.now(), MessageType.CHAT),
  new MessageData('http://picbed.demo.saintic.com/static/upload/huang/2020/03/26/15851851916789332.jpg', '梁典典', '明天请个家', new DateTime.now(), MessageType.CHAT),
  new MessageData('http://picbed.demo.saintic.com/static/upload/huang/2020/03/26/15851851917641119.jpg', '粑粑', '我要去个医院,打钱', new DateTime.now(), MessageType.CHAT),
  new MessageData('http://picbed.demo.saintic.com/static/upload/huang/2020/03/26/15851851917447129.jpg', '凤凤', '我也想你了', new DateTime.now(), MessageType.CHAT),
  new MessageData('http://picbed.demo.saintic.com/static/upload/huang/2020/03/26/15851851916902970.jpg', '胡歌', '晚上出来喝酒', new DateTime.now(), MessageType.CHAT),
];