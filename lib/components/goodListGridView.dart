import 'package:flutter/material.dart';
import '../models/good.dart';
import 'good_item.dart';

class GoodListGridView extends StatelessWidget {
  final List<GoodModel> list;
  final String title;
  GoodListGridView({Key key, this.list, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (list == null) {
      return Container();
    }
    // var _cur = GridView.count(
    //   shrinkWrap: true,
    //   //水平子Widget之间间距
    //   crossAxisSpacing: 5.0,
    //   //垂直子Widget之间间距
    //   mainAxisSpacing: 5.0,
    //   //GridView内边距
    //   // padding: EdgeInsets.all(10.0),
    //   //一行的Widget数量
    //   crossAxisCount: 2,
    //   //子Widget宽高比例
    //   childAspectRatio: 1.0,
    //   //子Widget列表
    //   children: list.map((item) {
    //     return GoodItem(goodInfo: item);
    //   }).toList(),
    // );
    List<Widget> _list = [];

    Widget renderTitle({String title}) {
      return SliverToBoxAdapter(
          child: Container(
        height: 40.0,
        color: Colors.white,
        child: Center(
          child: Text(title),
        ),
      ));
    }

    var _cur = SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 1.0),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return GoodItem(goodInfo: list[index]);
      }, childCount: list.length),
    );
    // _list.add(renderTitle(title: title));
    // _list.add(_cur);

    return _cur;
    // return SliverToBoxAdapter(
    //     child: Container(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       // Container(
    //       //     margin: const EdgeInsets.only(top: 10.0),
    //       //     color: Colors.white,
    //       //     height: 40.0,
    //       //     child: Flex(
    //       //       direction: Axis.horizontal,
    //       //       children: <Widget>[
    //       //         Padding(
    //       //           padding: const EdgeInsets.only(left: 20.0),
    //       //         ),
    //       //         Text(title)
    //       //       ],
    //       //       // child: ,
    //       //     )),
    //       // Divider(
    //       //   height: 1.0,
    //       //   color: Colors.black54,
    //       // ),
    //       _cur,
    //     ],
    //   ),
    // )
    // );
  }
}
