# 简介
```
该项目是一名前端初学flutter写的一个商城小应用，本文档主要讲述一些项目中遇到的坑或问题的解决思路等。
```
## 架构

-  路由:fluro
-  事件通讯: event_bus
   - 主要用于全局的loading或toast等的显示消失以及在A页面做某些操作，然后返回上层B页面引起B数据变化等的简单通讯。复杂的应该使用状态库。
-  缓存: sqflite
-  状态库: fish_redux 
   - 主要用于购物车的增删改查等，同时结合sqflite做数据持久化。其中购物车模型属于Global级状态，其余商品详情、购物车、结算等页面使用page层的状态。
-  请求库: dio
-  model: <a href="https://app.quicktype.io/" target="_href">https://app.quicktype.io/</a>
   - 该网站可以将json模型转dart模型，比较方便，安利。

## tips
- 如何区分环境
  定义一个环境的枚举，然后在启动时注入，具体可看services/config 以及main_mock或main等。
- 一个页面多次使用了ListView与GridView时，会有一些奇怪的问题，此时应该使用CustomScrollView组件将这些胶水组件粘合起来才能流畅。
   

## how to start
```
flutter run -t lib/main_mock.dart
```