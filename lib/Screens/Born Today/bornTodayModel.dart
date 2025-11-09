// To parse this JSON data, do
//
//     final borntodayModel = borntodayModelFromJson(jsonString);

import 'dart:convert';

BorntodayModel borntodayModelFromJson(String str) => BorntodayModel.fromJson(json.decode(str));

String borntodayModelToJson(BorntodayModel data) => json.encode(data.toJson());

class BorntodayModel {
    int count;
    List<Datum> data;

    BorntodayModel({
        required this.count,
        required this.data,
    });

    factory BorntodayModel.fromJson(Map<String, dynamic> json) => BorntodayModel(
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    String photoUrl;
    int age;
    String roleCategory;

    Datum({
        required this.id,
        required this.name,
        required this.photoUrl,
        required this.age,
        required this.roleCategory,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photo_url"],
        age: json["age"],
        roleCategory: json["role_category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo_url": photoUrl,
        "age": age,
        "role_category": roleCategory,
    };
}
