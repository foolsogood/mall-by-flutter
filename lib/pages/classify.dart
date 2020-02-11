import 'package:flutter/material.dart';
import '../services/api.dart';
import '../utils/net.dart';
import '../models/good.dart';
import '../routes/navigator_util.dart';
import '../routes/routers.dart';

class ClassifyPage extends StatefulWidget {
  @override
  _ClassifyPageState createState() => _ClassifyPageState();
}

class GoodListItemModel {
  int code;
  List<GoodModel> data;
  GoodListItemModel({this.code, this.data});
  factory GoodListItemModel.fromJson(Map<String, dynamic> json) =>
      GoodListItemModel(
        code: json['code'],
        data: List<GoodModel>.from(
            json["data"].map((x) => GoodModel.fromJson(x))),
      );
}

class _ClassifyPageState extends State<ClassifyPage> {
  List cateList=[];
  List<GoodListItemModel> goodList=[];
  ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCates();
  }

  void getCates() async {
    final url = Api.getCates;
    try {
      final response = await NetUtils.get(url);
      List<Map<String, dynamic>> temp = [];
      for (dynamic data in response['data']) {
        Map<String, dynamic> cate = {
          "cate": data['cate'],
          "cateId": data['cateId'],
        };
        temp.add(cate);
      }
      setState(() {
        cateList = temp;
      });
      final futureList = temp.map((item) {
        return getGoodsByCate(cateId: item["cateId"]);
      }).toList();
      getAllGoodsByCates(futureList: futureList);
    } catch (err) {
      print(err);
    }
  }

  void getAllGoodsByCates({List<Future> futureList}) async {
    final list = await Future.wait(futureList);
    List<GoodListItemModel> temp = [];
    for (var item in list) {
      GoodListItemModel goodItem = GoodListItemModel.fromJson(item);
      temp.add(goodItem);
    }
    setState(() {
      goodList = temp;
    });
  }

  Future getGoodsByCate({String cateId}) async {
    final url = Api.getGoodsByCate.replaceAll(':cateId', cateId);
    try {
      Future _fu = NetUtils.get(url);
      return _fu;
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget titleHandler() {
      if (cateList.length == 0) {
        return Container();
      }
      return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: false,
          padding: EdgeInsets.all(0.0),
          //滑动到底部回弹效果
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Row(
              children: cateList.map((item) {
                return Container(
                  width: 100.0,
                  height: 60.0,
                  child: Center(
                    child: Text(item["cate"]),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    }

    Widget listHandler() {
      if ( goodList.length == 0) {
        return Container();
      }
      return Container(
        // padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: goodList.map((item) {
            final goodListItem = item.data;
            var _cur = GridView.count(
              shrinkWrap: true,
              //水平子Widget之间间距
              crossAxisSpacing: 5.0,
              //垂直子Widget之间间距
              mainAxisSpacing: 5.0,
              //GridView内边距
              // padding: EdgeInsets.all(10.0),
              //一行的Widget数量
              crossAxisCount: 3,
              //子Widget宽高比例
              childAspectRatio: 0.75,
              //子Widget列表
              children: goodListItem.map((goodInfo) {
                return GestureDetector(
                  onTap: () {
                    NavigatorUtil.jump(context,
                        '${Routes.goodDetail}?goodId=${goodInfo.goodId}');
                  },
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Image.network(goodInfo.imgs[0]),
                        Text(goodInfo.goodName)
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
            return Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ListView(
                controller: _scrollController,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    color: Colors.white,
                    child: Center(
                      child: Text(item.data[0].cate),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black54,
                  ),
                  _cur
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    return Container(
      child: ListView(
        controller: _scrollController,
        children: <Widget>[titleHandler(), listHandler()],
      ),
    );
  }
}
