import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../components/rate.dart';

import '../../redux/Global_Shop_Cart/action.dart';
import '../../redux/Global_Shop_Cart/store.dart';

import 'action.dart';
import 'state.dart';

import '../../models/shopCartModel.dart';
import '../../routes/routers.dart';
import '../../routes/navigator_util.dart';

Widget buildView(
    GoodDetailState state, Dispatch dispatch, ViewService viewService) {
  var goodDetail = state.goodDetail;
  var goodId = state.goodId;
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
            child: Text(
              goodDetail.desction,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
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
    if (comments.length == 0) {
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
                            value: double.parse(item.rateScore).toInt(),
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
              // width: MediaQuery.of(context).size.width,
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
                          child: InkWell(
                            onTap: () {
                              NavigatorUtil.switchTab(
                                  viewService.context,0);
                            },
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.home, color: Colors.grey),
                                  Text("主页"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                NavigatorUtil.switchTab(
                                  viewService.context,1);
                                // NavigatorUtil.redirect(
                                //     viewService.context, Routes.classify);
                              },
                              child: Container(
                                height: 60.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.class_,
                                      color: Colors.grey,
                                    ),
                                    Text("分类")
                                  ],
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 3,
                          child: InkWell(
                              onTap: () {
                                Map<String, dynamic> _temp = {
                                  "goodId": goodDetail.goodId,
                                  "goodName": goodDetail.goodName,
                                  "price": goodDetail.price,
                                  "number": 1,
                                  "totalPrice": goodDetail.price,
                                  "isSelected": 1,
                                  "imgs": goodDetail.imgs[0],
                                };
                                ShopCartModel goodInfo =
                                    ShopCartModel.fromJson(_temp);
                                // dispatch(GoodDetailActionCreator.onAddToCart(goodId, goodInfo));
                                GlobalStore.store.dispatch(
                                    GlobalActionCreator.onAddToCartAction(
                                        goodId, goodInfo));
                              },
                              child: Container(
                                height: 60.0,
                                color: Colors.orangeAccent,
                                child: Center(
                                  child: Text("加入购物车",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )),
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
