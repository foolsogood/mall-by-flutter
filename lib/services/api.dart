import 'config.dart';

final server = Config.server;

class Api {
  static String getGoodsByCate = "$server/good/getGoodByCateId/:cateId";
  static String getGoodById = "$server/good/getGoodDetail/:goodId";
  static String getNewGoods = "$server/good/getNewGoods";
  static String getHotGoods = "$server/good/getHotGoods";
  static String searchGood = "$server/good/searchGood";
  static String collectGood = "$server/good/collectGood/:goodId";
  static String getCollectGood = "$server/good/getCollectGood";
  static String getGoodComment = "$server/good/getGoodComment/:goodId";
  static String addGoodComment = "$server/good/addGoodComment";
  static String getCates = "$server/category/getAllCategory";
  static String getHomeBanner = "$server/home/getBanner";
  static String login = "$server/user/login";
  static String signup = "$server/user/register";
  static String uploadAvatar = "$server/user/uploadAvatar";
  static String bindPhone = "$server/phone/bindPhone";
  static String sendSms = "$server/phone/sendSms";
}
