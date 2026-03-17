import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/core/usecase_interfase.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';

import 'package:think_and_wash/features/profile/domain/profile_repository.dart';

class GetProfileUsecase extends UseCase<User, NoParams> {
  final ProfileRepository repository;

  GetProfileUsecase({required this.repository});
  @override
  Future<Either<Failure, User>> call(NoParams entity) {
    return repository.getProfile();
  }
}
