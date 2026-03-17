import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/core/usecase_interfase.dart';
import 'package:think_and_wash/features/auth/data/auth_model.dart';
import 'package:think_and_wash/features/auth/domain/auth_entity.dart';
import 'package:think_and_wash/features/auth/domain/auth_repository.dart';

class SubmitOtpUsecase extends UseCase<AuthModel, AuthEntity> {
  final AuthRepository repository;

  SubmitOtpUsecase({required this.repository});
  @override
  Future<Either<Failure, AuthModel>> call(AuthEntity entity) {
    return repository.submitOtp(entity);
  }
}
