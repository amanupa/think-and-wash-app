import 'package:dartz/dartz.dart';
import 'package:think_and_wash/core/failure.dart';
import 'package:think_and_wash/core/usecase_interfase.dart';
import 'package:think_and_wash/features/order/data/model/order.dart';
import 'package:think_and_wash/features/order/domain/order_repository.dart';

class GetOrderUsecase extends UseCase<OrdersModel, NoParams> {
  final OrderRepository repository;

  GetOrderUsecase({required this.repository});
  @override
  Future<Either<Failure, OrdersModel>> call(NoParams entity) {
    return repository.getOrders();
  }
}
