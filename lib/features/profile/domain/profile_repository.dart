import 'package:dartz/dartz.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';
import 'package:think_and_wash/features/profile/domain/profile_entity.dart';

import '../../../core/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> updateProfile(ProfileEntity entity);
}
