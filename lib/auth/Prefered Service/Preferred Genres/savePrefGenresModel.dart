// To parse this JSON data, do
//
//     final saveGenresPrefModel = saveGenresPrefModelFromJson(jsonString);

import 'dart:convert';

SaveGenresPrefModel saveGenresPrefModelFromJson(String str) => SaveGenresPrefModel.fromJson(json.decode(str));

String saveGenresPrefModelToJson(SaveGenresPrefModel data) => json.encode(data.toJson());

class SaveGenresPrefModel {
    bool success;
    String message;

    SaveGenresPrefModel({
        required this.success,
        required this.message,
    });

    factory SaveGenresPrefModel.fromJson(Map<String, dynamic> json) => SaveGenresPrefModel(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}
