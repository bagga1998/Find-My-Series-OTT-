// To parse this JSON data, do
//
//     final preferredLanguagesModel = preferredLanguagesModelFromJson(jsonString);

import 'dart:convert';

PreferredLanguagesModel preferredLanguagesModelFromJson(String str) => PreferredLanguagesModel.fromJson(json.decode(str));

String preferredLanguagesModelToJson(PreferredLanguagesModel data) => json.encode(data.toJson());

class PreferredLanguagesModel {
    bool success;
    int count;
    List<Datum> data;

    PreferredLanguagesModel({
        required this.success,
        required this.count,
        required this.data,
    });

    factory PreferredLanguagesModel.fromJson(Map<String, dynamic> json) => PreferredLanguagesModel(
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
