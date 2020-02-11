import 'package:flutter/material.dart';
List statusList=[
  {
    "status":0,
    "text":"全部",
  },
  {
    "status":-1,
    "text":"待付款",
    "color":Colors.redAccent,
    "icon": Icons.payment,
  },
  {
    "status":1,
    "text":"待发货",
    "icon": Icons.send
  },
  {
    "status":2,
    "text":"待收货",
    "icon": Icons.call_received
  },
  {
    "status":99,
    "text":"待评价",
    "icon": Icons.comment
  },
];
List mockOrders = [
  {
    "shop": {
      "logo":
          "https://zhengxin-pub.bj.bcebos.com/logopic/f92eaa82260a2dbb710fa82d56a7cb42_fullsize.jpg?x-bce-process=image/resize,m_lfit,w_200",
      "name": "小米"
    },
    "cover": "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1581358071501&di=39af8b500cc17f2f31f4c841412870bd&imgtype=0&src=http%3A%2F%2Fimg0.pconline.com.cn%2Fpconline%2F1612%2F16%2F8674240_2_thumb.png",
    "name": "科沃斯扫地机器人",
    "status": -1,
    "attribute": [
      {"type": "颜色", "value": "蓝色"},
    ],
    "addValues": ["七天无理由", "返现20%"],
    "price": 88,
    "number": 2,
  },
  {
    "shop": {
      "logo":
          "https://zhengxin-pub.bj.bcebos.com/logopic/f92eaa82260a2dbb710fa82d56a7cb42_fullsize.jpg?x-bce-process=image/resize,m_lfit,w_200",
      "name": "小米"
    },
    "cover": "http://www.zyqhwj.com/uploads/allimg/190218/0330391421_0.jpeg",
    "name": "小米小爱同学",
    "status": 1,
    "attribute": [
      {"type": "颜色", "value": "黑色"},
      {"type": "规格", "value": "12g"},
    ],
    "addValues": ["七天无理由"],
    "price": 108,
    "number": 1,
  },
];
