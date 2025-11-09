// To parse this JSON data, do
//
//     final preferredLanguagesModel = preferredLanguagesModelFromJson(jsonString);

import 'dart:convert';

PreferredLanguagesModel preferredLanguagesModelFromJson(String str) => PreferredLanguagesModel.fromJson(json.decode(str));

String preferredLanguagesModelToJson(PreferredLanguagesModel data) => json.encode(data.toJson());

class PreferredLanguagesModel {
    bool success;
    String message;
    List<int> data;

    PreferredLanguagesModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory PreferredLanguagesModel.fromJson(Map<String, dynamic> json) => PreferredLanguagesModel(
        success: json["success"],
        message: json["message"],
        data: List<int>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
    };
}
