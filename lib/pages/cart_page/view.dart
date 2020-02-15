import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';


import '../../components/goodListGridView.dart';

// Widget buildView(CartState state, Dispatch dispatch, ViewService viewService) {
//   return Container();
// }
Widget buildView(CartState state, Dispatch dispatch, ViewService viewService) {
  var hotGoodsList=state.hotGoodsList;
  if(hotGoodsList==null){
    return Container();
  }
  Widget emptyHandler() {
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

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: emptyHandler(),
        ),
        renderTitle(title: '为你推荐'),
        GoodListGridView(list: hotGoodsList),
      ],
      // child: Column(
      //   children: <Widget>[
      //     emptyHandler(),
      //     GoodListGridView(list: hotGoodsList, title: "为你推荐"),
      //   ],
      // ),
    );
}
