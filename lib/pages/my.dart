import 'package:flutter/material.dart';
import '../routes/navigator_util.dart';
import '../routes/routers.dart';
import '../mock/orders.dart' show statusList;

class MyPage extends StatelessWidget {
  const MyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget topHandler() {
      return Stack(
        children: <Widget>[
          Container(
            child: Image.asset("assets/img/people_bg.png", fit: BoxFit.cover),
            height: 120.0,
          ),
          Positioned(
            left: 30.0,
            top: 30.0,
            child: Container(
              height: 80.0,
              width: 80.0,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/img/default-avatar.jpeg"),
                radius: 100.0,
              ),
            ),
          ),
          Positioned(
            left: 120.0,
            top: 80.0,
            child: Text("tycho"),
          ),
        ],
      );
    }

    Widget midHandler() {
      List orderList =statusList.where((item) => item["status"] != 0).toList();
          
      return Container(
          margin: const EdgeInsets.only(top: 10.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              InkWell(
                child: ListTile(
                  title: Text("我的订单"),
                  trailing: Icon(Icons.arrow_right),
                ),
                onTap: () {
                  NavigatorUtil.jump(context, Routes.order);
                },
              ),
              Divider(
                height: 1.0,
                color: Colors.black54,
              ),
              Row(
                children: orderList.map((item) {
                  return Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                          ),
                          Text(item["text"]),
                          Icon(item["icon"]),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                          ),
                        ],
                      ),
                      onTap: () {
                        NavigatorUtil.jump(context,
                            '${Routes.order}?typeId=${item["status"]}');
                      },
                    ),
                  );
                }).toList(),
              )
            ],
          ));
    }

    Widget listHandler() {
      List<Map<String, dynamic>> _list = [
        {
          "img": "assets/img/phone.png",
          "text": "绑定手机",
          "icon": Icon(
            Icons.phone,
            color: Colors.redAccent,
          )
        },
        {
          "img": "assets/img/collect.png",
          "text": "我的收藏",
          "icon": Icon(Icons.star, color: Colors.yellowAccent)
        },
        {
          "img": "assets/img/help.png",
          "text": "购物帮助",
          "icon": Icon(Icons.help, color: Colors.orangeAccent)
        },
        {
          "img": "assets/img/feedback.png",
          "text": "意见反馈",
          "icon": Icon(Icons.feedback, color: Colors.greenAccent)
        },
      ];
      return Container(
        margin: const EdgeInsets.only(top: 10.0),
        color: Colors.white,
        child: Column(
          children: ListTile.divideTiles(
                  context: context,
                  tiles: _list.map((item) {
                    return ListTile(
                      leading: item["icon"],
                      title: Text(item["text"]),
                      trailing: Icon(Icons.arrow_right),
                    );
                  }).toList())
              .toList(),
        ),
      );
    }

    return ListView(
      children: <Widget>[topHandler(), midHandler(), listHandler()],
    );
  }
}
