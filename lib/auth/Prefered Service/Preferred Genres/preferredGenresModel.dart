// To parse this JSON data, do
//
//     final preferredGenresModel = preferredGenresModelFromJson(jsonString);

import 'dart:convert';

PreferredGenresModel preferredGenresModelFromJson(String str) => PreferredGenresModel.fromJson(json.decode(str));

String preferredGenresModelToJson(PreferredGenresModel data) => json.encode(data.toJson());

class PreferredGenresModel {
    bool success;
    int count;
    List<Datum> data;

    PreferredGenresModel({
        required this.success,
        required this.count,
        required this.data,
    });

    factory PreferredGenresModel.fromJson(Map<String, dynamic> json) => PreferredGenresModel(
        success: json["success"],
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;

    Datum({
        required this.id,
        required this.name,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
