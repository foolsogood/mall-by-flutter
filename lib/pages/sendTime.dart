import 'package:flutter/material.dart';
import '../event/event_bus.dart';
import '../event/event_model.dart';
import '../routes/navigator_util.dart';

class SendTimePage extends StatefulWidget {
  @override
  _SendTimePageState createState() => _SendTimePageState();
}

class _SendTimePageState extends State<SendTimePage> {
  final List<Map<String, dynamic>> list = [
    {"text": "尽快"},
    {"text": "工作日送货"},
    {"text": "双休日，假日送货"},
    {"text": "不限时间"},
  ];
  int selectedIdx = 0;
  @override
  Widget build(BuildContext context) {
    Widget bottomBarHandler({Widget insertWidget}) {
      return Container(
        child: Stack(
          children: <Widget>[
            insertWidget,
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                    onTap: () {
                      String time = list[selectedIdx]["text"];
                      eventBus.fire(SendTimeEvent(time));
                      NavigatorUtil.goBack(context);
                    },
                    child: Container(
                      height: 60.0,
                      color: Colors.lightBlueAccent,
                      child: Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Text(
                            '确定',
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 10.0),
                          )
                        ],
                      ),
                    )))
          ],
        ),
      );
    }

    return Scaffold(
        body: bottomBarHandler(
            insertWidget: Container(
                child: Column(
      children: list.asMap().keys.map((idx) {
        return RadioListTile(
          title: Text(list[idx]["text"]),
          groupValue: selectedIdx,
          value: idx,
          selected: idx == selectedIdx,
          onChanged: (val) {
            print('$val');
            setState(() {
              selectedIdx = val;
            });
          },
        );
      }).toList(),
    ))));
  }
}
