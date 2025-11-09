// To parse this JSON data, do
//
//     final getAllSocialMedialModel = getAllSocialMedialModelFromJson(jsonString);

import 'dart:convert';

GetAllSocialMedialModel getAllSocialMedialModelFromJson(String str) => GetAllSocialMedialModel.fromJson(json.decode(str));

String getAllSocialMedialModelToJson(GetAllSocialMedialModel data) => json.encode(data.toJson());

class GetAllSocialMedialModel {
    bool success;
    List<Datum> data;

    GetAllSocialMedialModel({
        required this.success,
        required this.data,
    });

    factory GetAllSocialMedialModel.fromJson(Map<String, dynamic> json) => GetAllSocialMedialModel(
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
    String iconUrl;
    DateTime createdat;
    DateTime updatedat;

    Datum({
        required this.id,
        required this.name,
        required this.iconUrl,
        required this.createdat,
        required this.updatedat,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        iconUrl: json["icon_url"],
        createdat: DateTime.parse(json["createdat"]),
        updatedat: DateTime.parse(json["updatedat"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon_url": iconUrl,
        "createdat": createdat.toIso8601String(),
        "updatedat": updatedat.toIso8601String(),
    };
}
