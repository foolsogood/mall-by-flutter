import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import '../models/good.dart';
import '../models/banner.dart';
import '../services/api.dart';
import '../utils/net.dart';
import '../components/goodListGridView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerModel> banners = [];
  List<GoodModel> newGoodsList = [];
  List<GoodModel> hotGoodsList = [];

  @override
  void initState() {
    super.initState();

    getNewGoods();
    getHotGoods();

    getBanner();
  }

  void getNewGoods() async {
    final url = Api.getNewGoods;
    try {
      final response = await NetUtils.get(url);
      final temp = newGoodsList;
      // print(response);
      for (dynamic data in response['data']) {
        GoodModel newGood = GoodModel.fromJson(data);
        temp.add(newGood);
      }
      setState(() {
        newGoodsList = temp;
      });
    } catch (err) {
      print(err);
    }
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

  void getBanner() async {
    final url = Api.getHomeBanner;
    try {
      final response = await NetUtils.get(url);
      final temp = <BannerModel>[];
      // print(response);
      for (dynamic data in response['data']) {
        BannerModel banner = BannerModel.fromJson(data);
        temp.add(banner);
      }
      setState(() {
        banners = temp;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bannerHandler() {
      if (banners.length == 0) {
        return Container();
      }

      return Container(
        height: 200.0,
        child: Swiper(
          outer: false,
          itemHeight: 180.0,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Image.network(
                banners[index].url,
                fit: BoxFit.cover,
              ),
              height: 180.0,
            );
          },
          pagination: SwiperPagination(
            builder: SwiperPagination.dots,
          ),
          controller: SwiperController(),
          itemCount: banners.length,
          autoplay: true,
        ),
      );
    }

    Widget renderTitle({String title}) {
      return SliverToBoxAdapter(
          child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.black54))),
        child: ListTile(
          title: Text(title),
        ),
      ));
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: bannerHandler(),
            ),
            renderTitle(title: '最新商品'),
            GoodListGridView(list: newGoodsList),
            renderTitle(title: '热门商品'),
            GoodListGridView(list: hotGoodsList),
            // SliverPadding(
            //   padding: const EdgeInsets.all(8.0),
            //   sliver: GoodListGridView(list: newGoodsList, title: "最新商品"),
            // ),
            // SliverPadding(
            //   padding: const EdgeInsets.all(8.0),
            //   sliver: GoodListGridView(list: hotGoodsList, title: "热门商品"),
            // ),
          ],
        ));
  }
}
