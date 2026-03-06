import 'dart:convert';
import 'package:think_and_wash/core/api_clients.dart';
import 'package:think_and_wash/core/app_url.dart';
import 'package:think_and_wash/core/exception.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';
import 'package:think_and_wash/features/profile/domain/profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<User> updateProfile(ProfileEntity entity);
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<User> updateProfile(ProfileEntity entity) async {
    try {
      final url = AppUrl.host + AppUrl.updateProfile;

      final response = await ApiClient.post(url: url, body: entity.toJson());

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final authModel = AuthModel.fromJson(decoded);

        return authModel.user!;
      }
      throw ApiException(message: response.body);
    } catch (err) {
      throw ServerException();
    }
  }
}
