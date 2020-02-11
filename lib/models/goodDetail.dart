// To parse this JSON data, do
//
//     final goodDetailModel = goodDetailModelFromJson(jsonString);

import 'dart:convert';

GoodDetailModel goodDetailModelFromJson(String str) => GoodDetailModel.fromJson(json.decode(str));

String goodDetailModelToJson(GoodDetailModel data) => json.encode(data.toJson());

class GoodDetailModel {
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
    List<Comment> comments;

    GoodDetailModel({
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
        this.comments,
    });

    factory GoodDetailModel.fromJson(Map<String, dynamic> json) => GoodDetailModel(
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
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
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
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    int id;
    String goodId;
    String avatar;
    List<dynamic> imgList;
    String name;
    String rateScore;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;

    Comment({
        this.id,
        this.goodId,
        this.avatar,
        this.imgList,
        this.name,
        this.rateScore,
        this.comment,
        this.createdAt,
        this.updatedAt,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        goodId: json["goodId"],
        avatar: json["avatar"],
        imgList: json["imgList"] == null ? null : List<dynamic>.from(json["imgList"].map((x) => x)),
        name: json["name"],
        rateScore: json["rateScore"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "goodId": goodId,
        "avatar": avatar,
        "imgList": imgList == null ? null : List<dynamic>.from(imgList.map((x) => x)),
        "name": name,
        "rateScore": rateScore,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
