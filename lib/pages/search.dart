import 'package:flutter/material.dart';
import '../models/good.dart';
import '../services/api.dart';
import '../utils/net.dart';
import '../routes/navigator_util.dart';
import '../routes/routers.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<GoodModel> goodsList;
  TextEditingController _textFieldController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // searchGood('手机');
  }

  void searchGood(String keyword) async {
    final url = Api.searchGood;
    try {
      final response = await NetUtils.get(url, params: {"keyword": keyword});
      List<GoodModel> temp = [];
      print(response);
      for (dynamic data in response['data']) {
        GoodModel newGood = GoodModel.fromJson(data);
        temp.add(newGood);
      }
      setState(() {
        goodsList = temp;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget searchBarHandler() {
      Widget buildTextField() {
        //theme设置局部主题
        return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 25,
              maxHeight: 30,
            ),
            child: TextField(
              controller: _textFieldController,
              autofocus: true,
              maxLines: 1,

              // cursorColor: Colors.white, //设置光标
              decoration: InputDecoration(
                  //输入框decoration属性
                  // contentPadding: new EdgeInsets.only(left: 0.0),
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
//            fillColor: Colors.white,
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  hintText: "淘我想要",
                  hintStyle: new TextStyle(fontSize: 14, color: Colors.grey)),
              style: new TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  textBaseline: TextBaseline.alphabetic),

              onSubmitted: (v) {
                searchGood(v);
              },
            ));
      }

      Widget editView() {
        return Container(
          //修饰黑色背景与圆角
          decoration: new BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.0), //灰色的一层边框
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
          ),
          alignment: Alignment.center,
          // height: 36,
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          child: buildTextField(),
        );
      }

      return editView();
    }

    Widget listHandler() {
      if (goodsList == null) {
        return Container();
      }
      if (goodsList.length == 0) {
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
        shrinkWrap: true,
        children: ListTile.divideTiles(
                context: context,
                tiles: goodsList.map((item) {
                  return InkWell(
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            item.imgs[0],
                            fit: BoxFit.fitWidth,
                            width: 80.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(item.goodName),
                                Text(item.desction),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      NavigatorUtil.jump(context,
                          '${Routes.goodDetail}?goodId=${item.goodId}');
                    },
                  );
                }).toList())
            .toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: searchBarHandler(),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
          ),
          InkWell(
            child: Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 20.0, 0),
                child: Text('取消'),
              ),
            ),
            onTap: () {
              setState(() {
                _textFieldController.text = '';
                goodsList = null;
              });
            },
          ),
        ],
      ),
      body: listHandler(),
    );
  }
}
