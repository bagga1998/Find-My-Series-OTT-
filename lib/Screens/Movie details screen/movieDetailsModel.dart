// To parse this JSON data, do
//
//     final popularIndianMoviesDetailsModel = popularIndianMoviesDetailsModelFromJson(jsonString);

import 'dart:convert';

PopularIndianMoviesDetailsModel popularIndianMoviesDetailsModelFromJson(String str) => PopularIndianMoviesDetailsModel.fromJson(json.decode(str));

String popularIndianMoviesDetailsModelToJson(PopularIndianMoviesDetailsModel data) => json.encode(data.toJson());

class PopularIndianMoviesDetailsModel {
    bool success;
    Movie movie;
    List<dynamic> reviews;
    String summary;

    PopularIndianMoviesDetailsModel({
        required this.success,
        required this.movie,
        required this.reviews,
        required this.summary,
    });

    factory PopularIndianMoviesDetailsModel.fromJson(Map<String, dynamic> json) => PopularIndianMoviesDetailsModel(
        success: json["success"],
        movie: Movie.fromJson(json["movie"]),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        summary: json["summary"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "movie": movie.toJson(),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "summary": summary,
    };
}

class Movie {
    int id;
    String title;
    String description;
    DateTime releaseDate;
    int year;
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
    String thumbnailUrl;
    String trailerUrl;
    List<int> genres;
    List<int> languages;
    DateTime createdAt;
    DateTime updatedAt;
    List<String> genreNames;
    List<String> languageNames;
    String platformName;
    String certificateName;
    String statusName;

    Movie({
        required this.id,
        required this.title,
        required this.description,
        required this.releaseDate,
        required this.year,
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
        required this.thumbnailUrl,
        required this.trailerUrl,
        required this.genres,
        required this.languages,
        required this.createdAt,
        required this.updatedAt,
        required this.genreNames,
        required this.languageNames,
        required this.platformName,
        required this.certificateName,
        required this.statusName,
    });

    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        releaseDate: DateTime.parse(json["release_date"]),
        year: json["year"],
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
        thumbnailUrl: json["thumbnail_url"],
        trailerUrl: json["trailer_url"],
        genres: List<int>.from(json["genres"].map((x) => x)),
        languages: List<int>.from(json["languages"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        genreNames: List<String>.from(json["genre_names"].map((x) => x)),
        languageNames: List<String>.from(json["language_names"].map((x) => x)),
        platformName: json["platform_name"],
        certificateName: json["certificate_name"],
        statusName: json["status_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "year": year,
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
        "thumbnail_url": thumbnailUrl,
        "trailer_url": trailerUrl,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "genre_names": List<dynamic>.from(genreNames.map((x) => x)),
        "language_names": List<dynamic>.from(languageNames.map((x) => x)),
        "platform_name": platformName,
        "certificate_name": certificateName,
        "status_name": statusName,
    };
}
