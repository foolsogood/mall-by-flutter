import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import './application.dart';
import './routers.dart';
import '../pages/home.dart';
class NavigatorUtil{
  static void goBack(BuildContext context){
    Navigator.pop(context);
    // Application.router.pop(context);
  }
  // 带参数的返回
  static goBackWithParams(BuildContext context,result){
    Navigator.pop(context,result);
  }
  // 直接跳转，无返回
  static redirect(BuildContext context,String title){
    Navigator.popAndPushNamed(context, title);
  }
  // 正常跳转，有返回
  static Future jump(BuildContext context, String title) {
        return Application.router.navigateTo(context, title, transition: TransitionType.inFromRight);
        /// 指定了 转场动画
    }
    // 跳到首页 
    static Future toHomePage(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => route == null);
  }
}