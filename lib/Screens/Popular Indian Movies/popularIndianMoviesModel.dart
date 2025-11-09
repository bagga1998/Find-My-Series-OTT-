// To parse this JSON data, do
//
//     final popularIndianMoviesListModel = popularIndianMoviesListModelFromJson(jsonString);

import 'dart:convert';

PopularIndianMoviesListModel popularIndianMoviesListModelFromJson(String str) => PopularIndianMoviesListModel.fromJson(json.decode(str));

String popularIndianMoviesListModelToJson(PopularIndianMoviesListModel data) => json.encode(data.toJson());

class PopularIndianMoviesListModel {
    String message;
    List<Datum> data;

    PopularIndianMoviesListModel({
        required this.message,
        required this.data,
    });

    factory PopularIndianMoviesListModel.fromJson(Map<String, dynamic> json) => PopularIndianMoviesListModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String title;
    String description;
    DateTime releaseDate;
    int year;
    int genreId;
    int languageId;
    int platformId;
    int certificateId;
    int statusId;
    String duration;
    String country;
    String rating;
    String views;
    String videoUrl;
    bool isPopular;
    String type;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.title,
        required this.description,
        required this.releaseDate,
        required this.year,
        required this.genreId,
        required this.languageId,
        required this.platformId,
        required this.certificateId,
        required this.statusId,
        required this.duration,
        required this.country,
        required this.rating,
        required this.views,
        required this.videoUrl,
        required this.isPopular,
        required this.type,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        releaseDate: DateTime.parse(json["release_date"]),
        year: json["year"],
        genreId: json["genre_id"],
        languageId: json["language_id"],
        platformId: json["platform_id"],
        certificateId: json["certificate_id"],
        statusId: json["status_id"],
        duration: json["duration"],
        country: json["country"],
        rating: json["rating"],
        views: json["views"],
        videoUrl: json["video_url"],
        isPopular: json["is_popular"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "year": year,
        "genre_id": genreId,
        "language_id": languageId,
        "platform_id": platformId,
        "certificate_id": certificateId,
        "status_id": statusId,
        "duration": duration,
        "country": country,
        "rating": rating,
        "views": views,
        "video_url": videoUrl,
        "is_popular": isPopular,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
