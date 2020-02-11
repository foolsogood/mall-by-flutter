import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderItem extends StatelessWidget {
  final OrderModel orderInfo;
  OrderItem({
    Key key,
    this.orderInfo
  }):super(key:key);
  @override
  Widget build(BuildContext context) {
    if(orderInfo==null){
      return Container(
      );
    }
    Widget topHandler() {
      var shop=orderInfo.shop;
      return ListTile(
        leading: Container(
            width: 25.0,
            height: 25.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                shop.logo
              ),
              radius: 100.0,
            )),
        title: Text(shop.name),
        trailing: Text(orderInfo.statusText),
      );
    }

    Widget contentHandler() {
      return Container(
        child: Row(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: Image.network(
                  orderInfo.cover,
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.fitWidth,
                )),
            Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[Text(orderInfo.name), Text(orderInfo.price.toString())],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[Text(orderInfo.attributeJoinText), Text('x ${orderInfo.number}')],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[Text(orderInfo.addValuesJoinText)],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      );
    }

    Widget btHandler() {
      return Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text('包邮'), Text('共${orderInfo.number}件商品 合计 ${orderInfo.totalPrice}')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0,5.0,15.0,5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border:Border.all(
                      color: Colors.grey,
                      width: 1.0
                    )
                  ),
                  child: Text('删除订单'),
                ),
                
              ],
            )
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Column(
        children: <Widget>[
          topHandler(),
          Divider(
            height: 1.0,
            color: Colors.black54,
          ),
          contentHandler(),
          btHandler()
        ],
      ),
    );
  }
}
