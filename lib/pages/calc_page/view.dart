import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import '../../routes/routers.dart';
import '../../routes/navigator_util.dart';

Widget buildView(CalcState state, Dispatch dispatch, ViewService viewService) {
  int totalNumber = state.totalNumber;
  int totalPrice = state.totalPrice;
  var shopCart = state.shopCart;
  String sendTime=state.sendTime;
  print(shopCart);

  print('totalNumber is $totalNumber');
  print('totalPrice is $totalPrice');
  Widget topHandler() {
    return SliverToBoxAdapter(
        child: Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 5.0),
      child: Column(
          children: ListTile.divideTiles(
              context: viewService.context,
              tiles: <Widget>[
            InkWell(
              child: ListTile(
                title: Text('请选择地址'),
                trailing: Icon(Icons.arrow_right),
              ),
              onTap: () {
                // NavigatorUtil.jump(viewService.context, Routes.sendTime);
              },
            ),
            ListTile(
              title: Text('支付方式'),
              trailing: Icon(Icons.arrow_right),
            ),
            InkWell(
              onTap: (){
                NavigatorUtil.jump(viewService.context, Routes.sendTime);
                
              },
              child: ListTile(
              title: Text('送货时间'),
              subtitle: Text(sendTime??''),
              trailing: Icon(Icons.arrow_right),
            ),
            )
            ,
          ]).toList()),
    ));
  }

  Widget bottomBarHandler({Widget insertWidget}) {
    return Container(
      child: Stack(
        children: <Widget>[
          insertWidget,
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  Divider(
                    color: Colors.white30,
                    height: 1.0,
                  ),
                  Container(
                    color: Colors.white,
                    height: 60.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('共'),
                                    Text(
                                      totalNumber.toString(),
                                      style:
                                          TextStyle(color: Colors.orangeAccent),
                                    ),
                                    Text('件'),
                                    Text(' 共计')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      totalPrice.toString(),
                                      style:
                                          TextStyle(color: Colors.orangeAccent),
                                    ),
                                    Text(' 元')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 60.0,
                            color: Colors.orangeAccent,
                            child: Center(
                              child: Text("去付款",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget goodListHandler() {
    return SliverToBoxAdapter(
      child: ListView(
          shrinkWrap: true,
          children: ListTile.divideTiles(
                  context: viewService.context,
                  tiles: shopCart.values.map((item) {
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            item.imgs,
                            fit: BoxFit.fitWidth,
                            width: 80.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(item.goodName),
                                    Text('售价:¥ ${item.price} X ${item.number}'),
                                  ],
                                ),
                                Container(
                                  child: Text('${item.totalPrice}'),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList())
              .toList()),
    );
  }

  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: bottomBarHandler(
        insertWidget: CustomScrollView(
      slivers: <Widget>[topHandler(), goodListHandler()],
    )),
  );
}
