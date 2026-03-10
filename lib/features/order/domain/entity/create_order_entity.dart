class CreateOrderEntity {
  final String vendorId;
  final String pickupSlotId;
  final List<OrderItemEntity> items;
  final String address;
  final PaymentType paymentType;
  final int totalAmount;
  final String? transactionId;

  CreateOrderEntity({
    required this.vendorId,
    required this.pickupSlotId,
    required this.items,
    required this.address,
    required this.paymentType,
    required this.totalAmount,
    this.transactionId,
  });

  Map<String, dynamic> toJson() {
    return {
      "vendorId": vendorId,
      "pickupSlotId": pickupSlotId,
      "items": items.map((e) => e.toJson()).toList(),
      "address": address,
      "paymentType": paymentType.name,
      "totalAmount": totalAmount,
      if (transactionId != null) "transactionId": transactionId,
    };
  }
}

class OrderItemEntity {
  final String id;
  final int count;

  OrderItemEntity({required this.id, required this.count});

  Map<String, dynamic> toJson() {
    return {"itemId": id, "quantity": count};
  }
}

enum PaymentType { cod, paid }
