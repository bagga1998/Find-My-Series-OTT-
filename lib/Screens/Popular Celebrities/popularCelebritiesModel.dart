// To parse this JSON data, do
//
//     final getPopularCelebritiesModel = getPopularCelebritiesModelFromJson(jsonString);

import 'dart:convert';

GetPopularCelebritiesModel getPopularCelebritiesModelFromJson(String str) => GetPopularCelebritiesModel.fromJson(json.decode(str));

String getPopularCelebritiesModelToJson(GetPopularCelebritiesModel data) => json.encode(data.toJson());

class GetPopularCelebritiesModel {
    int count;
    List<Datum> data;

    GetPopularCelebritiesModel({
        required this.count,
        required this.data,
    });

    factory GetPopularCelebritiesModel.fromJson(Map<String, dynamic> json) => GetPopularCelebritiesModel(
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
    DateTime dob;
    String bio;
    String roleCategory;
    String photoUrl;
    String popularityScore;
    DateTime createdAt;

    Datum({
        required this.id,
        required this.name,
        required this.dob,
        required this.bio,
        required this.roleCategory,
        required this.photoUrl,
        required this.popularityScore,
        required this.createdAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
