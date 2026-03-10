import 'package:dartz/dartz.dart';
import 'package:flutter/rendering.dart';
import 'package:think_and_wash/core/exception.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/features/auth/data/auth_datasource.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';
import 'package:think_and_wash/features/auth/domain/auth_entity.dart';
import 'package:think_and_wash/features/auth/domain/auth_repository.dart';

import '../../../core/secure_storage.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource dataSource;

  AuthRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, String>> getOtp(String phn) async {
    try {
      final result = await dataSource.getOtp(phn);
      return right(result);
    } on ApiException catch (err) {
      return left(ApiFailure(message: err.message));
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AuthModel>> submitOtp(AuthEntity entity) async {
    try {
      final result = await dataSource.submitOtp(entity);
      debugPrint(
        "this is result token in submit otp repository ${result.token}",
      );
      if (result.token != null) {
        await SecureStorageService.writeData(
          key: "auth_token",
          value: result.token!,
        );
      }
      return right(result);
    } on ApiException catch (err) {
      return left(ApiFailure(message: err.message));
    } on ServerException {
      return left(ServerFailure());
    }
  }
}
