import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';
import 'package:think_and_wash/features/profile/data/remote_data_source.dart';
import 'package:think_and_wash/features/profile/domain/profile_entity.dart';
import 'package:think_and_wash/features/profile/domain/profile_repository.dart';

import '../../../core/shared_preference.dart';

import '../../../core/exception.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, User>> updateProfile(ProfileEntity entity) async {
    try {
      final result = await dataSource.updateProfile(entity);
      if (result.name != null) {
        await SharedPreferenceService.setString("userName", result.name!);
      }
      return right(result);
    } on ApiException catch (err) {
      return left(ApiFailure(message: err.message));
    } on ServerException {
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getProfile() async {
    try {
      final result = await dataSource.getProfile();
      if (result.name != null) {
        await SharedPreferenceService.setString("userName", result.name!);
      }
      return right(result);
    } on ApiException catch (err) {
      return left(ApiFailure(message: err.message));
    } on ServerException {
      return left(const ServerFailure());
    }
  }
}
