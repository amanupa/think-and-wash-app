import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:think_and_wash/core/api_clients.dart';
import 'package:think_and_wash/core/app_url.dart';
import 'package:think_and_wash/core/exception.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';
import 'package:think_and_wash/features/profile/domain/profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<User> updateProfile(ProfileEntity entity);
  Future<User> getProfile();
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl();

  /// Converts a [ProfileEntity] to a JSON map for the API request.
  Map<String, dynamic> _entityToJson(ProfileEntity entity) => {
    "name": entity.name,
    "email": entity.email,
    "gender": entity.gender,
    "address": entity.fullAddress,
    "landmark": entity.landmark,
    "pincode": entity.pincode,
  };

  @override
  Future<User> updateProfile(ProfileEntity entity) async {
    try {
      final url = AppUrl.host + AppUrl.updateProfile;

      final response = await ApiClient.post(
        url: url,
        body: _entityToJson(entity),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final user = User.fromJson(decoded["data"]);
        return user;
      }
      throw ApiException(message: response.body);
    } on ApiException {
      rethrow;
    } catch (err) {
      debugPrint("updateProfile error: $err");
      throw ServerException();
    }
  }

  @override
  Future<User> getProfile() async {
    try {
      final url = AppUrl.host + AppUrl.getProfile;

      final response = await ApiClient.post(url: url);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final user = User.fromJson(decoded["data"]);
        return user;
      }
      throw ApiException(message: response.body);
    } on ApiException {
      rethrow;
    } catch (err) {
      debugPrint("getProfile error: $err");
      throw ServerException();
    }
  }
}
