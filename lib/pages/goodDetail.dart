import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// import 'package:fish_redux/fish_redux.dart' as Fish;
// import '../redux/Global_Shop_Cart/action.dart';
// import '../redux/Global_Shop_Cart/state.dart';
// import '../redux/Global_Shop_Cart/reducer.dart';


import '../services/api.dart';
import '../utils/net.dart';
import '../models/goodDetail.dart';
import '../components/rate.dart';

class GoodDetailPage extends StatefulWidget {
  final String goodId;
  GoodDetailPage({Key key, this.goodId}) : super(key: key);
  @override
  _GoodDetailPageState createState() => _GoodDetailPageState();
}

class _GoodDetailPageState extends State<GoodDetailPage> {
  GoodDetailModel goodDetail;
  @override
  void initState() {
    super.initState();
    getGoodById();
  }

  void getGoodById() async {
    final _id = "42fbd746-ac54-4aed-87ce-fa36866969e0";
    // final url = Api.getGoodById.replaceAll(':goodId', widget.goodId);
    final url = Api.getGoodById.replaceAll(':goodId', _id);

    print(url);
    try {
      final response = await NetUtils.get(url);
      setState(() {
        goodDetail = GoodDetailModel.fromJson(response["data"]);
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (goodDetail == null) {
      return Container();
    }
    final banners = goodDetail.imgs;
    Widget bannersHandler() {
      if (banners.length == 0) {
        return Container();
      }
      return CarouselSlider(
        height: 180.0,
        autoPlay: true,
        viewportFraction: 1.0,
        initialPage: 0,
        items: banners.map((item) {
          return Container(
            child: Image.network(
              item,
              height: 180.0,
              fit: BoxFit.cover,
            ),
          );
        }).toList(),
      );
    }

    Widget titleHandler() {
      return Container(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        margin: const EdgeInsets.fromLTRB(0, 5.0, 0, 10.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 25.0,
              child: Text(goodDetail.goodName),
            ),
            Container(
              // height: 25.0,
              child: Text(goodDetail.desction,overflow: TextOverflow.ellipsis,maxLines: 2,),
            ),
            Container(
              height: 25.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(goodDetail.price.toString()),
                  Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget commentHandler() {
      final comments = goodDetail.comments;
      if(comments.length==0){
        return Container();
      }
      return Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: comments.map((item) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.white,
              height: 200.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    width: 50.0,
                    height: 50.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(item.avatar),
                      radius: 100.0,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(item.name),
                            Rate(
                              value:
                                  double.parse(item.rateScore).toInt(),
                            )
                          ],
                        ),
                        Container(
                          child: Text(item.createdAt.toString()),
                        ),
                        Container(
                          child: Text(item.comment),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    Widget desctionHandler() {
      final detailImgs = goodDetail.detailImg;
      return Container(
        // height: 400.0,
        child: Column(
          children: detailImgs.map((item) {
            return Container(
              child: Image.network(
                item,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            );
          }).toList(),
        ),
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
                            flex: 2,
                            child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.home,color: Colors.grey),
                                  Text("主页"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 60.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.class_,color: Colors.grey,),
                                  Text("分类")
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: (){
                                // dispatch(GlobalActionCreator.onAddToCartAction(goodId, goodInfo))
                              },
                              child: Container(
                              height: 60.0,
                              color: Colors.orangeAccent,
                              child: Center(
                                child: Text("加入购物车",
                                  style: TextStyle(color: Colors.white)),
                              ),
                            )
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 60.0,
                              color: Colors.redAccent,
                              child: Center(
                                child: Text(
                                "立即购买",
                                style: TextStyle(color: Colors.white),
                              ),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(goodDetail.goodName),
      ),
      body: bottomBarHandler(
          insertWidget: ListView(
        children: <Widget>[
          bannersHandler(),
          titleHandler(),
          commentHandler(),
          desctionHandler(),
        ],
      )),
    );
  }
}
