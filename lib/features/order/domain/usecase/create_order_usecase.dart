import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/core/usecase_interfase.dart';
import 'package:think_and_wash/features/order/data/model/order.dart';
import 'package:think_and_wash/features/order/domain/entity/create_order_entity.dart';
import 'package:think_and_wash/features/order/domain/order_repository.dart';

class CreateOrderUsecase extends UseCase<OrdersModel, CreateOrderEntity> {
  final OrderRepository repository;

  CreateOrderUsecase({required this.repository});

  @override
  Future<Either<Failure, OrdersModel>> call(CreateOrderEntity entity) {
    return repository.createOrder(entity);
  }
}
