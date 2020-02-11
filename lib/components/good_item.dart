import 'package:flutter/material.dart';
import '../models/good.dart';
import '../routes/navigator_util.dart';
import '../routes/routers.dart';

class GoodItem extends StatelessWidget {
  final GoodModel goodInfo;
  GoodItem({Key key, this.goodInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _curWidget = GestureDetector(
      onTap: () {
        NavigatorUtil.jump(
            context, '${Routes.goodDetail}?goodId=${goodInfo.goodId}');
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10.0),
        height: 180.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  goodInfo.imgs[0],
                  height: 80.0,
                ),
              ],
            ),
            Container(
              child: Text(
                goodInfo.goodName,
              ),
            ),
            Container(
              child: Text(
                goodInfo.price,
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            Container(
                child: Text(
              goodInfo.desction,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
      ),
    );
    return _curWidget;
  }
}
