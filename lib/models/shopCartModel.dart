// To parse this JSON data, do
//
//     final shopCartModel = shopCartModelFromJson(jsonString);

import 'dart:convert';

ShopCartModel shopCartModelFromJson(String str) => ShopCartModel.fromJson(json.decode(str));

String shopCartModelToJson(ShopCartModel data) => json.encode(data.toJson());

class ShopCartModel {
    String goodId;
    String goodName;
    int price;
    int number;
    int totalPrice;
    int isSelected;
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
        totalPrice: json["totalPrice"],
        isSelected: json["isSelected"],
        imgs: json["imgs"],
    );

    Map<String, dynamic> toJson() => {
        "goodId": goodId,
        "goodName": goodName,
        "price": price,
        "number": number,
        "totalPrice": totalPrice,
        "isSelected": isSelected,
        "imgs": imgs,
    };
}
