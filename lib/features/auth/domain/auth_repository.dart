import 'package:dartz/dartz.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';
import 'package:think_and_wash/features/auth/domain/auth_entity.dart';

import '../../../core/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> getOtp(String phn);
  Future<Either<Failure, AuthModel>> submitOtp(AuthEntity entity);
}
