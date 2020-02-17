import 'package:flutter/material.dart';
import '../utils/sqflite/shopcart_dbhelper.dart';
import '../models/shopCartModel.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(11);
    _getShopCartData();
    // final d = _getShopCartData();
    // print(d);
    // for(dynamic v in d){

    // }
  }

  void _getShopCartData() async {
    var dbHelper = ShopCartDBHelper();
    var shopCartData =await dbHelper.getShopCartData();
    print('shopCartData :$shopCartData');
    for(dynamic v in shopCartData){
      final a=ShopCartModel.fromJson(v);
print(a.goodName);
    }
    // return shopCartData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('1'),
      ),
    );
  }
}
