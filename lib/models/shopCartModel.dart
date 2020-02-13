// To parse this JSON data, do
//
//     final shopCartModel = shopCartModelFromJson(jsonString);

import 'dart:convert';

ShopCartModel shopCartModelFromJson(String str) => ShopCartModel.fromJson(json.decode(str));

String shopCartModelToJson(ShopCartModel data) => json.encode(data.toJson());

class ShopCartModel {
    String goodId;
    String goodName;
    String price;
    int number;
    int totalPrice;
    bool isSelected;
    String imgs;

    ShopCartModel({
        this.goodId,
        this.goodName,
        this.price,
        this.number,
        this.totalPrice,
        this.isSelected,
        this.imgs,
    });

    factory ShopCartModel.fromJson(Map<String, dynamic> json) => ShopCartModel(
        goodId: json["goodId"],
        goodName: json["goodName"],
        price: json["price"],
        number: json["number"],
        totalPrice: json["total_price"],
        isSelected: json["isSelected"],
        imgs: json["imgs"],
    );

    Map<String, dynamic> toJson() => {
        "goodId": goodId,
        "goodName": goodName,
        "price": price,
        "number": number,
        "total_price": totalPrice,
        "isSelected": isSelected,
        "imgs": imgs,
    };
}
