// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    bool success;
    String message;
    Data data;

    LoginModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    String token;
    User user;

    Data({
        required this.token,
        required this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
    };
}

class User {
    int id;
    String name;
    String email;
    int age;
    String gender;
    String state;
    bool isVerified;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.age,
        required this.gender,
        required this.state,
        required this.isVerified,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        age: json["age"],
        gender: json["gender"],
        state: json["state"],
        isVerified: json["isVerified"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "age": age,
        "gender": gender,
        "state": state,
        "isVerified": isVerified,
    };
}
