import 'package:fish_redux/fish_redux.dart';
import '../../models/goodDetail.dart';
// import '../../redux/Global_Shop_Cart/state.dart';
// import '../../models/shopCartModel.dart';

class GoodDetailState
    implements  Cloneable<GoodDetailState> {
  GoodDetailModel goodDetail;
  String goodId;
  // @override
  // Map<String, ShopCartModel> shopCart = {};
  // // 总数量
  // @override
  // int totalNumber;
  // // 商品总价格
  // @override
  // int totalPrice;
  @override
  GoodDetailState clone() {
    return GoodDetailState()
      // ..totalNumber = totalNumber
      // ..totalPrice = totalPrice
      // ..shopCart = shopCart
      ..goodDetail = goodDetail
      ..goodId = goodId;
  }
}

GoodDetailState initState(Map<String, dynamic> args) {
  // print(args);
  return GoodDetailState()..goodId = args["goodId"];
}
