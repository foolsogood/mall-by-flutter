import 'package:flutter/material.dart';
import 'content.dart';

///底部导航框架搭建
class WithBottomTab extends StatefulWidget {
  @override
  _WithBottomTabState createState() => _WithBottomTabState();
}

class _WithBottomTabState extends State<WithBottomTab> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final ContentPagerController _contentPagerController =
      ContentPagerController();

  @override
  Widget build(BuildContext context) {
    /**代表页面布局结构的组件，通过它我们可以轻松实现底部导航、顶部AppBar、侧拉抽屉、悬浮按钮等效果的页面布局**/
    return Scaffold(
      /**容器组件，通过它我们可以定义容器的背景、边框、渐变等效果**/
      body: Container(
        /**盒式装饰器，也是最常见的一种装饰器，通过它我们轻松描述容器盒子的样式**/
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffedeef0),
              Color(0xffe6e7e9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ContentPager(
          contentPagerController: _contentPagerController,
          onPageChanged: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            //控制内容区域滚动到指定位置
            _contentPagerController.jumpToPage(index);
            //修改状态
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomItem('首页', Icons.home, 0),
            _bottomItem('分类', Icons.class_, 1),
            _bottomItem('购物车', Icons.shopping_cart, 2),
            _bottomItem('我的', Icons.person, 3),
          ]),
    );
  }

  //封装底部Tab
  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }
}
