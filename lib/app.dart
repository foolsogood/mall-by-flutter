import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'routes/application.dart';
import 'routes/routers.dart';
import 'pages/common/with_bottom_tab.dart';
import 'package:oktoast/oktoast.dart';

import './pages/sendTime.dart';
import './pages/goodDetail_page/page.dart';
import './pages/cart_page/page.dart';
import './pages/calc_page/page.dart';

class App extends StatelessWidget {
  App() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
          title: '我的商城',
          home: WithBottomTab(),
          // home: SendTimePage(),


          // home: GoodDetailPage().buildPage({"goodId":"42fbd746-ac54-4aed-87ce-fa36866969e0"}),

          onGenerateRoute: Application.router.generator),
    );
  }
}
