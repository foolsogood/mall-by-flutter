import 'package:fish_redux/fish_redux.dart' as Fish;
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import '../../redux/Global_Shop_Cart/store.dart';
import '../../redux/Global_Shop_Cart/action.dart';

import '../../components/goodListGridView.dart';
import '../../components/stepper.dart';

import '../../routes/routers.dart';
import '../../routes/navigator_util.dart';

@override
Widget buildView(
    CartState state, Fish.Dispatch dispatch, Fish.ViewService viewService) {
  var hotGoodsList = state.hotGoodsList;
  int totalNumber = state.totalNumber;
  int totalPrice = state.totalPrice;
  var shopCart = state.shopCart;
  print(shopCart);
  // print('颜色:${state.themeColor}');

  print('totalNumber is $totalNumber');
  print('totalPrice is $totalPrice');

  if (hotGoodsList == null) {
    return Container();
  }
  Widget tipHandler() {
    return Container(
      height: 100.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.shopping_cart),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
            ),
            Text("购物车还是空的"),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFE0E0E0), width: 2.0),
              ),
              child: Text('去逛逛'),
            )
          ],
        ),
      ),
    );
  }

  Widget renderTitle({String title}) {
    return SliverToBoxAdapter(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))),
      child: ListTile(
        title: Text(title),
      ),
    ));
  }

  Widget emptyHandler() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: tipHandler(),
        ),
        renderTitle(title: '为你推荐'),
        GoodListGridView(list: hotGoodsList)
      ],
    );
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
                                    Text(' 金额')
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
                              child: Text("继续购物",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:InkWell(
                            onTap: (){
                              NavigatorUtil.jump(viewService.context,Routes.calc );
                            },
                          child: Container(
                            height: 60.0,
                            color: Colors.redAccent,
                            child: Center(
                              child: Text(
                                "去结算",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          )
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

  Widget notEmptyHandler() {
    return Container(
      child: bottomBarHandler(
          insertWidget: ListView(
              children: shopCart.values.map((item) {
        return Container(
          height: 120.0,
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFFE0E0E0)))),
          child: Row(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    int v = item.isSelected == 1 ? 0 : 1;
                    GlobalStore.store.dispatch(
                        GlobalActionCreator.onUpdateCartAction(
                            item.goodId, item.number, v));
                  },
                  child: Container(
                    width: 50.0,
                    child: Icon(item.isSelected == 1
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked),
                  )),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Image.network(
                      item.imgs,
                      fit: BoxFit.fitWidth,
                      width: 80.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.goodName),
                        Text('售价:¥ ${item.price}'),
                        SyStepper(
                          value: item.number,
                          onChange: (int value) {
                            GlobalStore.store.dispatch(
                                GlobalActionCreator.onUpdateCartAction(
                                    item.goodId, value, item.isSelected));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  GlobalStore.store.dispatch(
                      GlobalActionCreator.onDeleteCartAction(item.goodId));
                },
                child: Container(
                  width: 50.0,
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList())),
    );
  }

  return Scaffold(
      appBar: AppBar(
        backgroundColor: state.themeColor,
        title: Text("购物车"),
      ),
      body: shopCart == null||shopCart.values.toList().length==0 ? emptyHandler() : notEmptyHandler());
}
