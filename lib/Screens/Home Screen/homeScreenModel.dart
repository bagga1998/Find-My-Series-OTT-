// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
    bool success;
    String message;
    Data data;

    HomePageModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
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
    List<ComingSoon> topBanners;
    List<dynamic> popularIndianMovies;
    List<dynamic> popularIndianTvShows;
    List<PopularCelebrity> popularCelebrities;
    List<dynamic> releasedToday;
    List<dynamic> bornToday;
    List<NowStreaming> nowStreaming;
    List<ComingSoon> comingSoon;

    Data({
        required this.topBanners,
        required this.popularIndianMovies,
        required this.popularIndianTvShows,
        required this.popularCelebrities,
        required this.releasedToday,
        required this.bornToday,
        required this.nowStreaming,
        required this.comingSoon,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        topBanners: List<ComingSoon>.from(json["topBanners"].map((x) => ComingSoon.fromJson(x))),
        popularIndianMovies: List<dynamic>.from(json["popularIndianMovies"].map((x) => x)),
        popularIndianTvShows: List<dynamic>.from(json["popularIndianTVShows"].map((x) => x)),
        popularCelebrities: List<PopularCelebrity>.from(json["popularCelebrities"].map((x) => PopularCelebrity.fromJson(x))),
        releasedToday: List<dynamic>.from(json["releasedToday"].map((x) => x)),
        bornToday: List<BornToday>.from(json["bornToday"].map((x) => BornToday.fromJson(x))),
        nowStreaming: List<NowStreaming>.from(json["nowStreaming"].map((x) => NowStreaming.fromJson(x))),
        comingSoon: List<ComingSoon>.from(json["comingSoon"].map((x) => ComingSoon.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "topBanners": List<dynamic>.from(topBanners.map((x) => x.toJson())),
        "popularIndianMovies": List<dynamic>.from(popularIndianMovies.map((x) => x)),
        "popularIndianTVShows": List<dynamic>.from(popularIndianTvShows.map((x) => x)),
        "popularCelebrities": List<dynamic>.from(popularCelebrities.map((x) => x.toJson())),
        "releasedToday": List<dynamic>.from(releasedToday.map((x) => x)),
        "bornToday": List<dynamic>.from(bornToday.map((x) => x)),
        "nowStreaming": List<dynamic>.from(nowStreaming.map((x) => x.toJson())),
        "comingSoon": List<dynamic>.from(comingSoon.map((x) => x.toJson())),
    };
}

class ComingSoon {
    int id;
    String title;
    String thumbnailUrl;
    DateTime releaseDate;
    String? type;
    Platform platform;
    Certificate certificate;
    Certificate status;
    String? rating;
    String? trailerUrl;

    ComingSoon({
        required this.id,
        required this.title,
        required this.thumbnailUrl,
        required this.releaseDate,
        this.type,
        required this.platform,
        required this.certificate,
        required this.status,
        this.rating,
        this.trailerUrl,
    });

    factory ComingSoon.fromJson(Map<String, dynamic> json) => ComingSoon(
        id: json["id"],
        title: json["title"],
        thumbnailUrl: json["thumbnail_url"],
        releaseDate: DateTime.parse(json["release_date"]),
        type: json["type"],
        platform: Platform.fromJson(json["platform"]),
        certificate: Certificate.fromJson(json["certificate"]),
        status: Certificate.fromJson(json["status"]),
        rating: json["rating"],
        trailerUrl: json["trailer_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail_url": thumbnailUrl,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "type": type,
        "platform": platform.toJson(),
        "certificate": certificate.toJson(),
        "status": status.toJson(),
        "rating": rating,
        "trailer_url": trailerUrl,
    };
}

class NowStreaming {
    int id;
    String title;
    String thumbnailUrl;
    DateTime releaseDate;
    String? type;
    Platform platform;
    Certificate certificate;
    Certificate status;
    String? rating;
    String? trailerUrl;

    NowStreaming({
        required this.id,
        required this.title,
        required this.thumbnailUrl,
        required this.releaseDate,
        this.type,
        required this.platform,
        required this.certificate,
        required this.status,
        this.rating,
        this.trailerUrl,
    });

    factory NowStreaming.fromJson(Map<String, dynamic> json) => NowStreaming(
        id: json["id"],
        title: json["title"],
        thumbnailUrl: json["thumbnail_url"],
        releaseDate: DateTime.parse(json["release_date"]),
        type: json["type"],
        platform: Platform.fromJson(json["platform"]),
        certificate: Certificate.fromJson(json["certificate"]),
        status: Certificate.fromJson(json["status"]),
        rating: json["rating"],
        trailerUrl: json["trailer_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail_url": thumbnailUrl,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "type": type,
        "platform": platform.toJson(),
        "certificate": certificate.toJson(),
        "status": status.toJson(),
        "rating": rating,
        "trailer_url": trailerUrl,
    };
}



class TopBanners {
    int id;
    String title;
    String thumbnailUrl;
    DateTime releaseDate;
    String? type;
    Platform platform;
    Certificate certificate;
    Certificate status;
    String? rating;
    String? trailerUrl;

    TopBanners({
        required this.id,
        required this.title,
        required this.thumbnailUrl,
        required this.releaseDate,
        this.type,
        required this.platform,
        required this.certificate,
        required this.status,
        this.rating,
        this.trailerUrl,
    });

    factory TopBanners.fromJson(Map<String, dynamic> json) => TopBanners(
        id: json["id"],
        title: json["title"],
        thumbnailUrl: json["thumbnail_url"],
        releaseDate: DateTime.parse(json["release_date"]),
        type: json["type"],
        platform: Platform.fromJson(json["platform"]),
        certificate: Certificate.fromJson(json["certificate"]),
        status: Certificate.fromJson(json["status"]),
        rating: json["rating"],
        trailerUrl: json["trailer_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail_url": thumbnailUrl,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "type": type,
        "platform": platform.toJson(),
        "certificate": certificate.toJson(),
        "status": status.toJson(),
        "rating": rating,
        "trailer_url": trailerUrl,
    };
}


class Certificate {
    int id;
    String name;

    Certificate({
        required this.id,
        required this.name,
    });

    factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Platform {
    int id;
    String name;
    String iconUrl;

    Platform({
        required this.id,
        required this.name,
        required this.iconUrl,
    });

    factory Platform.fromJson(Map<String, dynamic> json) => Platform(
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

class BornToday {
    int id;
    String name;
    String photoUrl;
    String roleCategory;
    DateTime dob;
    String? popularityScore;

    BornToday({
        required this.id,
        required this.name,
        required this.photoUrl,
        required this.roleCategory,
        required this.dob,
        this.popularityScore,
    });

    factory BornToday.fromJson(Map<String, dynamic> json) => BornToday(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photo_url"],
        roleCategory: json["role_category"],
        dob: DateTime.parse(json["dob"]),
        popularityScore: json["popularity_score"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo_url": photoUrl,
        "role_category": roleCategory,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "popularity_score": popularityScore,
    };
}


class PopularCelebrity {
    int id;
    String name;
    String photoUrl;
    String roleCategory;
    DateTime dob;
    String popularityScore;

    PopularCelebrity({
        required this.id,
        required this.name,
        required this.photoUrl,
        required this.roleCategory,
        required this.dob,
        required this.popularityScore,
    });

    factory PopularCelebrity.fromJson(Map<String, dynamic> json) => PopularCelebrity(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photo_url"],
        roleCategory: json["role_category"],
        dob: DateTime.parse(json["dob"]),
        popularityScore: json["popularity_score"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo_url": photoUrl,
        "role_category": roleCategory,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "popularity_score": popularityScore,
    };
}
