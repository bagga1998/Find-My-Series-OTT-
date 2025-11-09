// To parse this JSON data, do
//
//     final allnewsModel = allnewsModelFromJson(jsonString);

import 'dart:convert';

AllnewsModel allnewsModelFromJson(String str) => AllnewsModel.fromJson(json.decode(str));

String allnewsModelToJson(AllnewsModel data) => json.encode(data.toJson());

class AllnewsModel {
    int count;
    List<Datum> data;

    AllnewsModel({
        required this.count,
        required this.data,
    });

    factory AllnewsModel.fromJson(Map<String, dynamic> json) => AllnewsModel(
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
    String title;
    String description;
    dynamic image;
    DateTime date;
    int platformId;
    List<String> genres;
    List<String> languages;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.title,
        required this.description,
        required this.image,
        required this.date,
        required this.platformId,
        required this.genres,
        required this.languages,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"]?? "",
        date: DateTime.parse(json["date"]),
        platformId: json["platform_id"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        languages: List<String>.from(json["languages"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "platform_id": platformId,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
