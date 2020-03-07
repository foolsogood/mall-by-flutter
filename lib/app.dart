import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'routes/application.dart';
import 'routes/routers.dart';
import 'pages/common/with_bottom_tab.dart';
import './event/event_bus.dart';
import './event/event_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import './pages/login.dart';
import './pages/goodDetail_page/page.dart';
import './pages/cart_page/page.dart';
import './pages/calc_page/page.dart';

class App extends StatelessWidget {
  App() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
    eventBus.on<ShowToastEvent>().listen((data) {
      final type = data.type;
      final msg = data.msg;
      EasyLoading.showToast(msg);
    });
    eventBus.on<LoadingEvent>().listen((data) {
      final type = data.type;
      final msg = data.msg;
      if (type == 'show') {
        EasyLoading.show(status: msg);
      }
      if (type == 'hide') {
        EasyLoading.dismiss();

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
        child: MaterialApp(
            title: '我的商城',
            home: WithBottomTab(),
            // home: LoginPage(),

            // home: GoodDetailPage().buildPage({"goodId":"42fbd746-ac54-4aed-87ce-fa36866969e0"}),

            onGenerateRoute: Application.router.generator));
  }
}
