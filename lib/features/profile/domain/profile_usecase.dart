import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/core/usecase_interfase.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';
import 'package:think_and_wash/features/profile/domain/profile_entity.dart';
import 'package:think_and_wash/features/profile/domain/profile_repository.dart';

class ProfileUsecase extends UseCase<User, ProfileEntity> {
  final ProfileRepository repository;

  ProfileUsecase({required this.repository});
  @override
  Future<Either<Failure, User>> call(ProfileEntity entity) {
    return repository.updateProfile(entity);
  }
}
