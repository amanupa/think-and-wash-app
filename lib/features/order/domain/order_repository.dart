import 'package:think_and_wash/features/order/domain/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getOrders(String usrId);
  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  });
}
