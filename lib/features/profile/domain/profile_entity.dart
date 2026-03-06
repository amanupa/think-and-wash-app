import 'dart:convert';

class ProfileEntity {
  final String name;
  final String email;
  final String gender;
  final String fullAddress;
  final String landmark;
  final String pincode;

  ProfileEntity({
    required this.name,
    required this.email,
    required this.gender,
    required this.fullAddress,
    required this.landmark,
    required this.pincode,
  });
  String authModelToJson(ProfileEntity entity) => json.encode(entity.toJson());
  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "gender": gender,
    "address": fullAddress,
    "landmark": landmark,
    "pincode": pincode,
  };
}
