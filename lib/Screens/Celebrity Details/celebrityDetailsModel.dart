// To parse this JSON data, do
//
//     final celebrityDetailsModel = celebrityDetailsModelFromJson(jsonString);

import 'dart:convert';

CelebrityDetailsModel celebrityDetailsModelFromJson(String str) => CelebrityDetailsModel.fromJson(json.decode(str));

String celebrityDetailsModelToJson(CelebrityDetailsModel data) => json.encode(data.toJson());

class CelebrityDetailsModel {
    Data data;

    CelebrityDetailsModel({
        required this.data,
    });

    factory CelebrityDetailsModel.fromJson(Map<String, dynamic> json) => CelebrityDetailsModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String name;
    DateTime dob;
    String bio;
    String roleCategory;
    String photoUrl;
    String popularityScore;
    DateTime createdAt;

    Data({
        required this.id,
        required this.name,
        required this.dob,
        required this.bio,
        required this.roleCategory,
        required this.photoUrl,
        required this.popularityScore,
        required this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        dob: DateTime.parse(json["dob"]),
        bio: json["bio"],
        roleCategory: json["role_category"],
        photoUrl: json["photo_url"],
        popularityScore: json["popularity_score"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "bio": bio,
        "role_category": roleCategory,
        "photo_url": photoUrl,
        "popularity_score": popularityScore,
        "created_at": createdAt.toIso8601String(),
    };
}
