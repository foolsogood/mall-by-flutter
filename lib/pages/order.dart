import 'package:flutter/material.dart';
import '../components/orderItem.dart';
import '../models/order.dart';
import '../mock/orders.dart' show statusList, mockOrders;

class OrderPage extends StatefulWidget {
  final String typeId;
  OrderPage({Key key, this.typeId}) : super(key: key);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  List<OrderModel> orderList;
  TabController mTabController;
  int initialIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mTabController = TabController(vsync: this, length: statusList.length);
    mTabController.addListener(() {
      // print('index is ${mTabController.index}');
      // print('previousIndex is ${mTabController.previousIndex}');
      // print('indexIsChanging is ${mTabController.indexIsChanging}');

      // if (mTabController.indexIsChanging) {
      getOrders(currentIdx: statusList[mTabController.index]["status"]);
      // }
    });
    if (widget.typeId != null) {
      final _idx = statusList
          .indexWhere((item) => item["status"] == int.parse(widget.typeId));
      print('当前status为${widget.typeId},下标$_idx');
      setState(() {
        initialIndex = _idx;
      });
      getOrders(currentIdx: int.parse(widget.typeId));
    } else {
      getOrders(currentIdx: 0);
    }
  }

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
  }

// 处理json增加接口自定义的字段
  Map<String, dynamic> merge({Map<String, dynamic> data}) {
    Map<String, dynamic> temp = data;
    temp["attribute_join_text"] =
        List<dynamic>.from(data["attribute"]).map((v) {
      return '${v["type"]}:${v["value"]} ';
    }).join();
    temp["addValues_join_text"] =
        List<dynamic>.from(data["addValues"]).join(" ");
    temp["status_text"] =
        statusList.singleWhere((v) => v["status"] == data["status"])["text"];
    temp["total_price"] = data["price"] * data["number"];
    return temp;
  }

  void getOrders({int currentIdx}) {
    setState(() {
      orderList = null;
    });
    // 全部
    if (currentIdx == 0) {
      var list = mockOrders.map((item) {
        item = merge(data: item);
        return OrderModel.fromJson(item);
      }).toList();
      setState(() {
        orderList = list;
      });
    } else {
      var temp = mockOrders.where((item) => item["status"] == currentIdx);
      var list = temp.map((item) {
        item = merge(data: item);
        return OrderModel.fromJson(item);
      }).toList();
      setState(() {
        orderList = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        initialIndex: initialIndex,
        length: statusList.length,
        child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (context, bool) {
                  return [
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(
                            "我的订单",
                          ),
                          background: Image.asset(
                            'assets/img/people_bg.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    new SliverPersistentHeader(
                      delegate: SliverTabBarDelegate(
                        new TabBar(
                          tabs: statusList
                              .map((item) => Tab(text: item["text"]))
                              .toList(),
                          indicatorColor: Colors.red,
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.red,
                          onTap: (int idx) {
                            getOrders(currentIdx: statusList[idx]["status"]);
                          },
                          controller: mTabController,
                        ),
                        color: Colors.white,
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                    controller: mTabController,
                    children: statusList.map((s) {
                      if (orderList == null) {
                        return Container();
                      }
                      if (orderList.length == 0) {
                        return Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.hourglass_empty,
                                  color: Colors.grey,
                                ),
                                Text('暂无数据')
                              ],
                            ),
                          ),
                        );
                      }
                      return ListView(
                        children: orderList.map((v) {
                          return OrderItem(
                            orderInfo: v,
                          );
                        }).toList(),
                      );
                      // return SliverFixedExtentList(
                      //   itemExtent: 50.0,
                      //   delegate: SliverChildBuilderDelegate(
                      //       (BuildContext context, int index) {
                      //     return OrderItem(
                      //       orderInfo: orderList[index],
                      //     );
                      //   }, childCount: orderList.length),
                      // );
                    }).toList()))));
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}
