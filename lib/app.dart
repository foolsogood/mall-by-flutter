import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'routes/application.dart';
import 'routes/routers.dart';
import 'pages/common/with_bottom_tab.dart';
// import './pages/goodDetail.dart';
import './pages/goodDetail_page/page.dart';

import './pages/test.dart';

class App extends StatelessWidget {
  App() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '我的商城',
        home: WithBottomTab(),
        // home: GoodDetailPage().buildPage({"goodId":"42fbd746-ac54-4aed-87ce-fa36866969e0"}),

        onGenerateRoute: Application.router.generator);
  }
}
