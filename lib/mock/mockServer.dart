import 'banner.dart';
import 'category.dart';
import 'comments.dart';
import 'good.dart';
import '../services/api.dart';

class MockServer {
  static Map<String, dynamic> getHomeBanner() {
    return {"data": banners, "code": 1};
  }

  static Map<String, dynamic> getHotGoods() {
    List d = goods.where((item) => item["isHot"] == 1).toList();
    return {"data": d, "code": 1};
  }

  static Map<String, dynamic> getNewGoods() {
    List d = goods.where((item) => item["isNew"] == 1).toList();
    return {"data": d, "code": 1};
  }

  static Map<String, dynamic> getCates() {
    return {"data": categorys, "code": 1};
  }

  static Map<String, dynamic> getGoodsByCate(String cateId) {
    List d = goods.where((item) => item["cateId"] == cateId).toList();

    return {"data": d, "code": 1};
  }

  static Map<String, dynamic> getGoodById(String goodId) {
    Map<String, dynamic> d =
        goods.firstWhere((item) => item["goodId"] == goodId);
    List c = comments.where((item) => item["goodId"] == goodId).toList();
    d["comments"] = c;
    return {"data": d, "code": 1};
  }

  Map<String, dynamic> getData(String url) {
    RegExp regExpGoodDetail = new RegExp(r"\/good\/getGoodDetail\/(\w)+");
    RegExp regExpGoodsByCate = new RegExp(r"\/good\/getGoodByCateId\/(\w)+");
    if (regExpGoodDetail.hasMatch(url)) {
      var goodId = url.replaceAll('/good/getGoodDetail/', '');
      return getGoodById(goodId);
    }
    if (regExpGoodsByCate.hasMatch(url)) {
      var cateId = url.replaceAll('/good/getGoodByCateId/', '');
      return getGoodsByCate(cateId);
    }
    Map<String, Function> o = {
      Api.getHomeBanner: getHomeBanner,
      Api.getNewGoods: getNewGoods,
      Api.getHotGoods: getHotGoods,
      Api.getCates: getCates,
    };
    return o[url]();
  }
}
