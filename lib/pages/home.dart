import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import '../models/good.dart';
import '../models/banner.dart';
import '../services/api.dart';
import '../utils/net.dart';
import '../components/goodListGridView.dart';
import '../routes/navigator_util.dart';
import '../routes/routers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerModel> banners = [];
  List<GoodModel> newGoodsList = [];
  List<GoodModel> hotGoodsList = [];
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus) {
    //   }
    // });
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
            border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))),
        child: ListTile(
          title: Text(title),
        ),
      ));
    }

    Widget topHandler() {
      Widget buildTextField() {
        //theme设置局部主题
        return TextField(
          focusNode: _focusNode,
          // cursorColor: Colors.white, //设置光标
          decoration: InputDecoration(
              //输入框decoration属性
              contentPadding: new EdgeInsets.only(left: 0.0),
//            fillColor: Colors.white,
              border: InputBorder.none,
              icon: Icon(Icons.search),
              hintText: "淘我想要",
              hintMaxLines: 1,
              hintStyle: new TextStyle(fontSize: 14, color: Colors.grey)),
          style: new TextStyle(fontSize: 14, color: Colors.grey),
          onTap: () {
            NavigatorUtil.jump(context, Routes.search);
            _focusNode.unfocus();
          },
        );
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
          height: 36,
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          child: buildTextField(),
        );
      }

      return editView();
    }

    return Scaffold(
        appBar: AppBar(
          title: topHandler(),
          // backgroundColor: Colors.black,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: bannerHandler(),
            ),
            renderTitle(title: '最新商品'),
            GoodListGridView(list: newGoodsList),
            renderTitle(title: '热门商品'),
            GoodListGridView(list: hotGoodsList),
          ],
        ));
  }
}
