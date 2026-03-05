// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  bool success;
  String message;
  String token;
  User user;

  AuthModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    success: json["success"],
    message: json["message"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String phone;
  bool isVerified;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String role;
  String address;
  String email;
  String gender;
  String landmark;
  String name;
  String pincode;

  User({
    required this.id,
    required this.phone,
    required this.isVerified,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.role,
    required this.address,
    required this.email,
    required this.gender,
    required this.landmark,
    required this.name,
    required this.pincode,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    phone: json["phone"],
    isVerified: json["isVerified"],
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    role: json["role"],
    address: json["address"],
    email: json["email"],
    gender: json["gender"],
    landmark: json["landmark"],
    name: json["name"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "phone": phone,
    "isVerified": isVerified,
    "isActive": isActive,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "role": role,
    "address": address,
    "email": email,
    "gender": gender,
    "landmark": landmark,
    "name": name,
    "pincode": pincode,
  };
}
