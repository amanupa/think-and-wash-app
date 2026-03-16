import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/exception.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/features/categories/data/datasource/remote/categories_remote_data_source.dart';
import 'package:think_and_wash/features/categories/data/model/category_model.dart';
import 'package:think_and_wash/features/categories/domain/repository/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CategoryItemModel>> getCategories(
    String vendorId,
  ) async {
    try {
      final result = await remoteDataSource.getCategories(vendorId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message));
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
