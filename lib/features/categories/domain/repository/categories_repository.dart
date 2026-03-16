import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/features/categories/data/model/category_model.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, CategoryItemModel>> getCategories(String vendorId);
}
