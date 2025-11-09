// To parse this JSON data, do
//
//     final getLanguagePrefModel = getLanguagePrefModelFromJson(jsonString);

import 'dart:convert';

GetLanguagePrefModel getLanguagePrefModelFromJson(String str) => GetLanguagePrefModel.fromJson(json.decode(str));

String getLanguagePrefModelToJson(GetLanguagePrefModel data) => json.encode(data.toJson());

class GetLanguagePrefModel {
    bool success;
    List<Datum> data;

    GetLanguagePrefModel({
        required this.success,
        required this.data,
    });

    factory GetLanguagePrefModel.fromJson(Map<String, dynamic> json) => GetLanguagePrefModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
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
