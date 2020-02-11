// To parse this JSON data, do
//
//     final goodModel = goodModelFromJson(jsonString);

import 'dart:convert';

GoodModel goodModelFromJson(String str) => GoodModel.fromJson(json.decode(str));

String goodModelToJson(GoodModel data) => json.encode(data.toJson());

class GoodModel {
    int id;
    String cateId;
    String cate;
    String goodId;
    String goodName;
    List<String> imgs;
    String desction;
    String price;
    int isHot;
    int isNew;
    List<String> detailImg;
    DateTime createdAt;
    DateTime updatedAt;

    GoodModel({
        this.id,
        this.cateId,
        this.cate,
        this.goodId,
        this.goodName,
        this.imgs,
        this.desction,
        this.price,
        this.isHot,
        this.isNew,
        this.detailImg,
        this.createdAt,
        this.updatedAt,
    });

    factory GoodModel.fromJson(Map<String, dynamic> json) => GoodModel(
        id: json["id"],
        cateId: json["cateId"],
        cate: json["cate"],
        goodId: json["goodId"],
        goodName: json["goodName"],
        imgs: List<String>.from(json["imgs"].map((x) => x)),
        desction: json["desction"],
        price: json["price"],
        isHot: json["isHot"],
        isNew: json["isNew"],
        detailImg: List<String>.from(json["detailImg"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cateId": cateId,
        "cate": cate,
        "goodId": goodId,
        "goodName": goodName,
        "imgs": List<dynamic>.from(imgs.map((x) => x)),
        "desction": desction,
        "price": price,
        "isHot": isHot,
        "isNew": isNew,
        "detailImg": List<dynamic>.from(detailImg.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
