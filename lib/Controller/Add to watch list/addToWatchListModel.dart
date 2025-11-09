// To parse this JSON data, do
//
//     final addToWatchListModel = addToWatchListModelFromJson(jsonString);

import 'dart:convert';

AddToWatchListModel addToWatchListModelFromJson(String str) => AddToWatchListModel.fromJson(json.decode(str));

String addToWatchListModelToJson(AddToWatchListModel data) => json.encode(data.toJson());

class AddToWatchListModel {
    bool success;
    String message;
    Data data;

    AddToWatchListModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory AddToWatchListModel.fromJson(Map<String, dynamic> json) => AddToWatchListModel(
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
    String status;
    DateTime updatedAt;
    DateTime createdAt;

    Data({
        required this.id,
        required this.userId,
        required this.movieId,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        movieId: json["movieId"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "movieId": movieId,
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}
