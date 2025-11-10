// To parse this JSON data, do
//
//     final ottPreferencesModel = ottPreferencesModelFromJson(jsonString);

import 'dart:convert';

OttPreferencesModel ottPreferencesModelFromJson(String str) => OttPreferencesModel.fromJson(json.decode(str));

String ottPreferencesModelToJson(OttPreferencesModel data) => json.encode(data.toJson());

class OttPreferencesModel {
    bool success;
    int count;
    List<Datum> data;

    OttPreferencesModel({
        required this.success,
        required this.count,
        required this.data,
    });

    factory OttPreferencesModel.fromJson(Map<String, dynamic> json) => OttPreferencesModel(
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
    String iconUrl;

    Datum({
        required this.id,
        required this.name,
        required this.iconUrl,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        iconUrl: json["icon_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon_url": iconUrl,
    };
}
