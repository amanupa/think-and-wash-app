import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/features/order/data/datasource/remote_datasource.dart';
import 'package:think_and_wash/features/order/data/model/order.dart';
import 'package:think_and_wash/features/order/domain/entity/create_order_entity.dart';
import 'package:think_and_wash/features/order/domain/order_repository.dart';

import '../../../core/exception.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderRemoteDataSource dataSource;

  OrderRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, OrdersModel>> createOrder(
    CreateOrderEntity entity,
  ) async {
    try {
      final result = await dataSource.createOrder(entity);
      return right(result);
    } on ApiException catch (err) {
      return left(ApiFailure(message: err.message));
    } on ServerException {
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrdersModel>> getOrders() async {
    try {
      final result = await dataSource.getOrders();
      return right(result);
    } on ApiException catch (err) {
      return left(ApiFailure(message: err.message));
    } on ServerException {
      return left(const ServerFailure());
    }
  }
}
