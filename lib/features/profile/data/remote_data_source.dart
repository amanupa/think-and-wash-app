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
  @override
  Future<User> updateProfile(ProfileEntity entity) async {
    try {
      final url = AppUrl.host + AppUrl.updateProfile;

      final response = await ApiClient.post(url: url, body: entity.toJson());
      debugPrint(
        "this is the respose status code in update profile: ${response.statusCode}",
      );

      if (response.statusCode == 200) {
        debugPrint("update profile response body: ${response.body}");

        final decoded = jsonDecode(response.body);

        final user = User.fromJson(decoded["data"]);
        debugPrint("before returning in update profile: ${user.email}");

        return user;
      }
      throw ApiException(message: response.body);
    } catch (err) {
      throw ServerException();
    }
  }

  @override
  Future<User> getProfile() async {
    try {
      final url = AppUrl.host + AppUrl.getProfile;

      final response = await ApiClient.post(url: url);
      debugPrint(
        "this is the respose status code in get profile: ${response.statusCode}",
      );

      if (response.statusCode == 200) {
        debugPrint("get profile response body: ${response.body}");

        final decoded = jsonDecode(response.body);

        final user = User.fromJson(decoded["data"]);
        debugPrint("before returning in get profile: ${user.email}");

        return user;
      }
      throw ApiException(message: response.body);
    } catch (err) {
      throw ServerException();
    }
  }
}
