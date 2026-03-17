import 'dart:convert';

OrdersModel orderModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str) ?? {});

String orderModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  bool success;
  int page;
  int total;
  List<Datum> data;

  OrdersModel({
    this.success = false,
    this.page = 0,
    this.total = 0,
    this.data = const [],
  });

  factory OrdersModel.fromJson(Map<String, dynamic>? json) => OrdersModel(
    success: json?["success"] ?? false,
    page: json?["page"] ?? 0,
    total: json?["total"] ?? 0,
    data: (json?["data"] as List<dynamic>?)
            ?.map((x) => Datum.fromJson(x as Map<String, dynamic>?))
            .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "page": page,
    "total": total,
    "data": data.map((x) => x.toJson()).toList(),
  };
}

class Datum {
  String id;
  String customerId;
  String vendorId;
  String pickupSlotId;

  DateTime? slotDate;
  DateTime? slotStart;
  DateTime? slotEnd;

  String timezone;

  int itemCount;
  String address;

  String userName;
  String userPhone;

  String venName;
  String venPhone;

  String paymentType;

  String? transactionId;

  List<Item> items;

  OrdersStatus? status;

  String? cancellationReason;

  int totalAmount;

  bool isDeleted;

  DateTime? createdAt;
  DateTime? updatedAt;

  int v;

  Datum({
    this.id = "",
    this.customerId = "",
    this.vendorId = "",
    this.pickupSlotId = "",
    this.slotDate,
    this.slotStart,
    this.slotEnd,
    this.timezone = "",
    this.itemCount = 0,
    this.address = "",
    this.userName = "",
    this.userPhone = "",
    this.venName = "",
    this.venPhone = "",
    this.paymentType = "",
    this.transactionId,
    this.items = const [],
    this.status,
    this.cancellationReason,
    this.totalAmount = 0,
    this.isDeleted = false,
    this.createdAt,
    this.updatedAt,
    this.v = 0,
  });

  factory Datum.fromJson(Map<String, dynamic>? json) => Datum(
    id: json?["_id"] ?? "",
    customerId: json?["customerId"] ?? "",
    vendorId: json?["vendorId"] ?? "",
    pickupSlotId: json?["pickupSlotId"] ?? "",
    slotDate:
        json?["slotDate"] != null ? DateTime.tryParse(json!["slotDate"]) : null,
    slotStart:
        json?["slotStart"] != null
            ? DateTime.tryParse(json!["slotStart"])
            : null,
    slotEnd:
        json?["slotEnd"] != null ? DateTime.tryParse(json!["slotEnd"]) : null,
    timezone: json?["timezone"] ?? "",
    itemCount: json?["itemCount"] ?? 0,
    address: json?["address"] ?? "",
    userName: json?["userName"] ?? "",
    userPhone: json?["userPhone"] ?? "",
    venName: json?["venName"] ?? "",
    venPhone: json?["venPhone"] ?? "",
    paymentType: json?["paymentType"] ?? "",
    transactionId: json?["transactionId"],
    items: (json?["items"] as List<dynamic>?)
            ?.map((x) => Item.fromJson(x as Map<String, dynamic>?))
            .toList() ??
        [],
    status: (json?["status"] ?? "booked").toString().toOrderStatus(),
    cancellationReason: json?["cancellationReason"],
    totalAmount: json?["totalAmount"] ?? 0,
    isDeleted: json?["isDeleted"] ?? false,
    createdAt:
        json?["createdAt"] != null
            ? DateTime.tryParse(json!["createdAt"])
            : null,
    updatedAt:
        json?["updatedAt"] != null
            ? DateTime.tryParse(json!["updatedAt"])
            : null,
    v: json?["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerId": customerId,
    "vendorId": vendorId,
    "pickupSlotId": pickupSlotId,
    "slotDate": slotDate?.toIso8601String(),
    "slotStart": slotStart?.toIso8601String(),
    "slotEnd": slotEnd?.toIso8601String(),
    "timezone": timezone,
    "itemCount": itemCount,
    "address": address,
    "userName": userName,
    "userPhone": userPhone,
    "venName": venName,
    "venPhone": venPhone,
    "paymentType": paymentType,
    "transactionId": transactionId,
    "items": items.map((x) => x.toJson()).toList(),
    "status": status,
    "cancellationReason": cancellationReason,
    "totalAmount": totalAmount,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Item {
  String itemId;
  String categoryName;
  String itemName;

  int quantity;
  int price;
  int subtotal;

  Item({
    this.itemId = "",
    this.categoryName = "",
    this.itemName = "",
    this.quantity = 0,
    this.price = 0,
    this.subtotal = 0,
  });

  factory Item.fromJson(Map<String, dynamic>? json) => Item(
    itemId: json?["itemId"] ?? "",
    categoryName: json?["categoryName"] ?? "",
    itemName: json?["itemName"] ?? "",
    quantity: json?["quantity"] ?? 0,
    price: json?["price"] ?? 0,
    subtotal: json?["subtotal"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "categoryName": categoryName,
    "itemName": itemName,
    "quantity": quantity,
    "price": price,
    "subtotal": subtotal,
  };
}

enum OrdersStatus { booked, picked, delivery, delivered, cancelled }

extension OrdersStatusX on String {
  OrdersStatus toOrderStatus() {
    switch (this) {
      case "booked":
        return OrdersStatus.booked;
      case "picked":
        return OrdersStatus.picked;
      case "delivery":
        return OrdersStatus.delivery;
      case "delivered":
        return OrdersStatus.delivered;
      case "cancelled":
        return OrdersStatus.cancelled;
      default:
        return OrdersStatus.booked;
    }
  }
}
