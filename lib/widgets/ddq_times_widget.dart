import 'package:flutter/material.dart';
import '../modals/ddq_modal.dart';
import '../provider/ddq_provider.dart';
import './up_down_btn_widget.dart';

class DdqTimesWidget extends StatelessWidget {
  List<RoundsList> timesList;
  DdqProvider ddqProvider;

  DdqTimesWidget({@required this.timesList,@required this.ddqProvider});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _buildTimes(),
      ),
    );
  }

  List<Widget> _buildTimes() {
    List<Widget> list = [];
    List<RoundsList> times = timesList;
    for (var timeItem in times) {
      //上层文字
      String upText =
          "${timeItem.ddqTime.hour.toString().padLeft(2, "0")}:${timeItem.ddqTime.minute.toString().padLeft(2, "0")}";

      //下层文字
      int state = timeItem.status;
      String downText = "已开抢";
      if (state == 1) {
        downText = "正在疯抢";
      }
      if (state == 2) {
        downText = "未开始";
      }

      //选中
      bool isCur = this.ddqProvider.ddqTime == timeItem.ddqTime;

      list.add(InkWell(
        onTap: () {
          this.ddqProvider.timeChange(timeItem.ddqTime, timeItem.status);
        },
        child:
        UpDownBtnWidget(upText: upText, downText: downText, isCur: isCur),
      ));
    }
    return list;
  }
}
