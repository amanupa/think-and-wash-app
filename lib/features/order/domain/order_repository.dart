import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/features/order/data/model/order.dart';
import 'package:think_and_wash/features/order/domain/entity/create_order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrdersModel>> getOrders();
  Future<Either<Failure, bool>> createOrder(CreateOrderEntity entity);
}
