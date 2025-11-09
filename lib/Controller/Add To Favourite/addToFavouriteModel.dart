// To parse this JSON data, do
//
//     final addToFavouriteModel = addToFavouriteModelFromJson(jsonString);

import 'dart:convert';

AddToFavouriteModel addToFavouriteModelFromJson(String str) => AddToFavouriteModel.fromJson(json.decode(str));

String addToFavouriteModelToJson(AddToFavouriteModel data) => json.encode(data.toJson());

class AddToFavouriteModel {
    bool success;
    String message;
    Data data;

    AddToFavouriteModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory AddToFavouriteModel.fromJson(Map<String, dynamic> json) => AddToFavouriteModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    int userId;
    int movieId;
    DateTime updatedAt;
    DateTime createdAt;

    Data({
        required this.id,
        required this.userId,
        required this.movieId,
        required this.updatedAt,
        required this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        movieId: json["movieId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "movieId": movieId,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}
