// To parse this JSON data, do
//
//     final getAllSavedGenresModel = getAllSavedGenresModelFromJson(jsonString);

import 'dart:convert';

GetAllSavedGenresModel getAllSavedGenresModelFromJson(String str) => GetAllSavedGenresModel.fromJson(json.decode(str));

String getAllSavedGenresModelToJson(GetAllSavedGenresModel data) => json.encode(data.toJson());

class GetAllSavedGenresModel {
    bool success;
    int count;
    List<Datum> data;

    GetAllSavedGenresModel({
        required this.success,
        required this.count,
        required this.data,
    });

    factory GetAllSavedGenresModel.fromJson(Map<String, dynamic> json) => GetAllSavedGenresModel(
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
