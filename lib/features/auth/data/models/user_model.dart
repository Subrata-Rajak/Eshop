// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String message;
  String token;
  UserClass user;

  User({
    required this.message,
    required this.token,
    required this.user,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        message: json["message"],
        token: json["token"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user.toJson(),
      };
}

class UserClass {
  String name;
  String email;
  String password;
  String gender;
  String phone;
  String id;
  int v;

  UserClass({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.phone,
    required this.id,
    required this.v,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
        phone: json["phone"],
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "gender": gender,
        "phone": phone,
        "_id": id,
        "__v": v,
      };
}
