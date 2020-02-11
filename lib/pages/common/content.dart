
// import 'package:beauty_flutter/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../home.dart';
import '../classify.dart';
import '../cart.dart';
import '../my.dart';

class ContentPager extends StatefulWidget {
  final ValueChanged<int> onPageChanged;
  final ContentPagerController contentPagerController;

  //构造方法，可选参数
  const ContentPager({Key key, this.onPageChanged, this.contentPagerController})
      /**初始化列表@https://coding.imooc.com/learn/list/321.html**/
      : super(key: key);

  @override
  _ContentPagerState createState() => _ContentPagerState();
}

class _ContentPagerState extends State<ContentPager> {
  PageController _pageController = PageController(
      /**视窗比例**/
      viewportFraction: 1.0);
  @override
  void initState() {
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
            _wrapItem(CartPage()),
            _wrapItem(MyPage()),
          ],
        ))
      ],
    );
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
