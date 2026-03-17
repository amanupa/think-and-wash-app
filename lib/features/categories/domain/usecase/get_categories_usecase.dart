import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/features/categories/data/model/category_model.dart';
import 'package:think_and_wash/features/categories/domain/repository/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, CategoryItemModel>> call(String vendorId) async {
    return await repository.getCategories(vendorId);
  }
}
