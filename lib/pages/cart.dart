import 'package:flutter/material.dart';
import '../components/goodListGridView.dart';
import '../services/api.dart';
import '../utils/net.dart';
import '../models/good.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<GoodModel> hotGoodsList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotGoods();
  }

  void getHotGoods() async {
    final url = Api.getHotGoods;
    try {
      final response = await NetUtils.get(url);
      final temp = hotGoodsList;
      // print(response);
      for (dynamic data in response['data']) {
        GoodModel newGood = GoodModel.fromJson(data);
        temp.add(newGood);
      }
      setState(() {
        hotGoodsList = temp;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0
                    ),
                    ),
                child: Text('去逛逛'),
              )
            ],
          ),
        ),
      );
    }

    return Container(
      child: Column(
        children: <Widget>[
          emptyHandler(),
          GoodListGridView(list: hotGoodsList, title: "为你推荐"),
        ],
      ),
    );
  }
}
