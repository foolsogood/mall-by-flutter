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
  List cateList = [];
  List<GoodListItemModel> goodList = [];
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
        // return Container();
      return  SliverToBoxAdapter(
            child: Container(),
          );
      }
      var con = Container(
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
      return SliverPersistentHeader(
          pinned: true, delegate: CustomSliverDelegate(widget: con)
          );
    }

    List<Widget> listHandler() {
      if (goodList.length == 0) {
        return List<Container>();
      }
      // return Container(
      //   child: ListView(
      //     controller: _scrollController,
      //     shrinkWrap: true,
      //     children: goodList.map((item) {
      //       final goodListItem = item.data;
      //       var _cur = GridView.count(
      //         shrinkWrap: true,
      //         //水平子Widget之间间距
      //         crossAxisSpacing: 5.0,
      //         //垂直子Widget之间间距
      //         mainAxisSpacing: 5.0,
      //         //GridView内边距
      //         // padding: EdgeInsets.all(10.0),
      //         //一行的Widget数量
      //         crossAxisCount: 3,
      //         //子Widget宽高比例
      //         childAspectRatio: 0.75,
      //         //子Widget列表
      //         children: goodListItem.map((goodInfo) {
      //           return GestureDetector(
      //             onTap: () {
      //               NavigatorUtil.jump(context,
      //                   '${Routes.goodDetail}?goodId=${goodInfo.goodId}');
      //             },
      //             child: Container(
      //               color: Colors.white,
      //               child: Column(
      //                 children: <Widget>[
      //                   Image.network(goodInfo.imgs[0]),
      //                   Text(goodInfo.goodName)
      //                 ],
      //               ),
      //             ),
      //           );
      //         }).toList(),
      //       );
      //       return Container(
      //         margin: const EdgeInsets.only(top: 10.0),
      //         child: ListView(
      //           controller: _scrollController,
      //           shrinkWrap: true,
      //           children: <Widget>[
      //             Container(
      //               height: 40.0,
      //               color: Colors.white,
      //               child: Center(
      //                 child: Text(item.data[0].cate),
      //               ),
      //             ),
      //             Divider(
      //               height: 1.0,
      //               color: Colors.black54,
      //             ),
      //             _cur
      //           ],
      //         ),
      //       );
      //     }).toList(),
      //   ),
      // );
      List<Widget> _list = [];
      Widget renderTitle({String title}) {
        return SliverToBoxAdapter(
            child: Container(
          margin: const EdgeInsets.fromLTRB(0, 2.0, 0, 2.0),
          height: 40.0,
          color: Colors.white,
          child: Center(
            child: Text(title),
          ),
        ));
      }

      Widget renderGrid({GoodListItemModel goodListItem}) {
        return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //Grid按两列显示
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 0.75,
            ),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int idx) {
              final goodInfo = goodListItem.data[idx];
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
            }, childCount: goodListItem.data.length));
      }

      goodList.forEach((goodListItem) {
        _list.add(renderTitle(title: goodListItem.data[0].cate));
        _list.add(renderGrid(goodListItem: goodListItem));
      });
      // var _list = goodList.map((goodListItem) {
      //   return
      //   SliverGrid(
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 3, //Grid按两列显示
      //       mainAxisSpacing: 5.0,
      //       crossAxisSpacing: 5.0,
      //       childAspectRatio: 0.75,
      //     ),
      //     delegate: SliverChildBuilderDelegate((BuildContext context, int idx) {
      //       final goodInfo = goodListItem.data[idx];
      //       return GestureDetector(
      //         onTap: () {
      //           NavigatorUtil.jump(
      //               context, '${Routes.goodDetail}?goodId=${goodInfo.goodId}');
      //         },
      //         child: Container(
      //           color: Colors.white,
      //           child: Column(
      //             children: <Widget>[
      //               Image.network(goodInfo.imgs[0]),
      //               Text(goodInfo.goodName)
      //             ],
      //           ),
      //         ),
      //       );
      //     }, childCount: goodListItem.data.length),
      //   );
      // }).toList();
      return _list;
      // return SliverPadding(
      //     padding: const EdgeInsets.all(8.0),
      //     sliver: SliverFixedExtentList(
      //       itemExtent: 50.0,
      //       delegate:
      //           SliverChildBuilderDelegate((BuildContext context, int index) {
      //         final goodListItem = goodList[index];
      //         print(goodListItem);
      //         return SliverGrid(
      //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 3, //Grid按两列显示
      //             mainAxisSpacing: 5.0,
      //             crossAxisSpacing: 5.0,
      //             childAspectRatio: 0.75,
      //           ),
      //           delegate:
      //               SliverChildBuilderDelegate((BuildContext context, int idx) {
      //             return Container(
      //                 margin: const EdgeInsets.only(top: 10.0),
      //                 child: Text('123')
      //                 //  Container(
      //                 //   color: Colors.white,
      //                 //   child: Column(
      //                 //     children: <Widget>[
      //                 //       // Image.network(goodInfo.imgs[0]),
      //                 //       // Text(goodInfo.goodName)

      //                 //     ],
      //                 //   ),
      //                 // )
      //                 );
      //           }, childCount: goodListItem.data.length),
      //         );
      //       }, childCount: goodList.length),
      //     ));
    }

    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          titleHandler(),
          // SliverToBoxAdapter(
          //   child: titleHandler(),
          // ),
          ...listHandler(),
        ],
      ),
    );
    // return Container(
    //   child: ListView(
    //     controller: _scrollController,
    //     children: <Widget>[titleHandler(), listHandler()],
    //   ),
    // );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final Container widget;
  CustomSliverDelegate({Key key, this.widget});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  } // 头部展示内容

  @override
  double get maxExtent => 50.0; // 最大高度

  @override
  double get minExtent => 50.0; // 最小高度

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      false; // 因为所有的内容都是固定的，所以不需要更新
}
