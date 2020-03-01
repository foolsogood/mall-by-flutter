// import 'package:beauty_flutter/custom_appbar.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import '../home.dart';
import '../classify.dart';
import '../cart_page/page.dart';
import '../my.dart';

import '../../redux/Global_Shop_Cart/store.dart';
import '../../redux/Global_Shop_Cart/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ContentPager extends StatefulWidget {
  final ValueChanged<int> onPageChanged;
  final ContentPagerController contentPagerController;
  final int tabIndex;

  //构造方法，可选参数
  const ContentPager(
      {Key key, this.tabIndex, this.onPageChanged, this.contentPagerController})
      /**初始化列表@https://coding.imooc.com/learn/list/321.html**/
      : super(key: key);

  @override
  _ContentPagerState createState() => _ContentPagerState();
}

class _ContentPagerState extends State<ContentPager> {
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(
        initialPage: widget.tabIndex ?? 0,
        /**视窗比例**/
        viewportFraction: 1.0);
    if (widget.contentPagerController != null) {
      widget.contentPagerController._pageController = _pageController;
    }
    _statusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            //高度撑开，否则在Column中没有高度会报错
            child: PageView(
          onPageChanged: widget.onPageChanged,
          controller: _pageController,
          children: <Widget>[
            _wrapItem(HomePage()),
            _wrapItem(ClassifyPage()),
            _cartPage(),
            // _wrapItem(CartPage().buildPage({})),
            _wrapItem(MyPage()),
          ],
        ))
      ],
    );
  }

  Widget _cartPage() {
    var page = CartPage();
    bool flag = page.isTypeof<GlobalBaseState>();
    // print('flag--- is $flag');
    if (flag) {
      page.connectExtraStore<GlobalState>(GlobalStore.store,
          (Object pagestate, GlobalState appState) {
        // final GlobalBaseState p=pagestate;
        // if(p.totalNumber!=appState.totalNumber){
        // print('===++==');

        if (pagestate is Cloneable) {
          final Object copy = pagestate.clone();
          final GlobalBaseState newState = copy;
          newState.shopCart = appState.shopCart;
          newState.totalNumber = appState.totalNumber;
          newState.totalPrice = appState.totalPrice;
          newState.themeColor = appState.themeColor;

          return newState;
        }
        // }
        return pagestate;
      });
    }
    return page.buildPage({});
  }

  Widget _wrapItem(Widget widget) {
    return Container(
      // padding: EdgeInsets.only(top: 20),
      child: widget,
    );
  }

  ///状态栏样式-沉浸式状态栏
  _statusBar() {
    //黑色沉浸式状态栏，基于SystemUiOverlayStyle.dark修改了statusBarColor
    SystemUiOverlayStyle uiOverlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );

    SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
  }
}

///内容区域的控制器
class ContentPagerController {
  PageController _pageController;

  void jumpToPage(int page) {
    //dart 编程技巧：安全的调用 @https://coding.imooc.com/learn/list/321.html
    _pageController?.jumpToPage(page);
  }
}
