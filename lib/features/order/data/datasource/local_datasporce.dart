import '../../domain/order_entity.dart';
import '../../domain/order_repository.dart';

class MockOrderRepository implements OrderRepository {
  @override
  Future<List<OrderEntity>> getOrders(String usrId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      OrderEntity(
        id: "1",
        customerId: "user_01",
        vendorId: "ven_t&w_01",
        itemCount: 5,
        address: "Chandigarh University",
        userName: "Aman Upadhyay",
        userPhone: "9876543210",
        paymentType: PaymentType.cod,
        items: const [],
        orderDate: DateTime.now(),
        deliveryDate: DateTime.now().add(const Duration(days: 2)),
        status: OrderStatus.pickup,
        totalAmount: 450,
      ),

      OrderEntity(
        id: "4",
        customerId: "user_01",
        vendorId: "ven_t&w_01",
        itemCount: 8,
        address: "Chandigarh University Kharar",
        userName: "Aman Kumar Upadhyay",
        userPhone: "9988776655",
        paymentType: PaymentType.paid,
        items: const [],
        orderDate: DateTime.now(),
        deliveryDate: DateTime.now().add(const Duration(days: 3)),
        status: OrderStatus.delivery,
        totalAmount: 600,
      ),

      OrderEntity(
        id: "7",
        customerId: "user_01",
        vendorId: "ven_t&w_01",
        itemCount: 7,
        address: "Chandigarh University Kharar",
        userName: "Aman Kumar Upadhyay",
        userPhone: "9988776655",
        paymentType: PaymentType.cod,
        items: const [],
        orderDate: DateTime.now(),
        deliveryDate: DateTime.now().add(const Duration(days: 3)),
        status: OrderStatus.delivery,
        totalAmount: 950,
      ),
    ];
  }

  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  }) async {}
}
