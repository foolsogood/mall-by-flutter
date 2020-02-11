// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    Shop shop;
    String cover;
    String name;
    int status;
    List<Attribute> attribute;
    List<String> addValues;
    int price;
    int number;
    String attributeJoinText;
    String addValuesJoinText;
    String statusText;
    int totalPrice;

    OrderModel({
        this.shop,
        this.cover,
        this.name,
        this.status,
        this.attribute,
        this.addValues,
        this.price,
        this.number,
        this.attributeJoinText,
        this.addValuesJoinText,
        this.statusText,
        this.totalPrice,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        shop: Shop.fromJson(json["shop"]),
        cover: json["cover"],
        name: json["name"],
        status: json["status"],
        attribute: List<Attribute>.from(json["attribute"].map((x) => Attribute.fromJson(x))),
        addValues: List<String>.from(json["addValues"].map((x) => x)),
        price: json["price"],
        number: json["number"],
        attributeJoinText: json["attribute_join_text"],
        addValuesJoinText: json["addValues_join_text"],
        statusText: json["status_text"],
        totalPrice: json["total_price"],
    );

    Map<String, dynamic> toJson() => {
        "shop": shop.toJson(),
        "cover": cover,
        "name": name,
        "status": status,
        "attribute": List<dynamic>.from(attribute.map((x) => x.toJson())),
        "addValues": List<dynamic>.from(addValues.map((x) => x)),
        "price": price,
        "number": number,
        "attribute_join_text": attributeJoinText,
        "addValues_join_text": addValuesJoinText,
        "status_text": statusText,
        "total_price": totalPrice,
    };
}

class Attribute {
    String type;
    String value;

    Attribute({
        this.type,
        this.value,
    });

    factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
    };
}

class Shop {
    String logo;
    String name;

    Shop({
        this.logo,
        this.name,
    });

    factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        logo: json["logo"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "logo": logo,
        "name": name,
    };
}
