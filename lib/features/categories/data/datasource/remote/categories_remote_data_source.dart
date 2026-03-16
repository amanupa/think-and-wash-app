import 'package:flutter/widgets.dart';
import 'package:think_and_wash/core/api_clients.dart';
import 'package:think_and_wash/core/app_url.dart';
import 'package:think_and_wash/core/exception.dart';
import 'package:think_and_wash/features/categories/data/model/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoryItemModel> getCategories(String vendorId);
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  @override
  Future<CategoryItemModel> getCategories(String vendorId) async {
    try {
      final url = AppUrl.host + AppUrl.getCategories;
      debugPrint("Calling Categories API: $url");

      final response = await ApiClient.post(
        url: url,
        body: {"vendorId": vendorId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return categoryItemModelFromJson(response.body);
      }
      throw ApiException(
        message: "Failed to fetch categories: ${response.statusCode}",
      );
    } on ApiException {
      rethrow;
    } catch (err) {
      debugPrint("Categories API Error: $err");
      throw ServerException();
    }
  }
}
