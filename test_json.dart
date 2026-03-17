import 'dart:convert';
import 'package:think_and_wash/features/order/data/model/order.dart';

void main() {
  const jsonString = '''
  {"success":true,"page":1,"total":4,"data":[{"_id":"69b8f9d0947f3db7b43ba1fc","customerId":"69ad0c010b452ce0a66d358d","vendorId":"69ae5cc549a2b6ad583acc8a","pickupSlotId":"69b8e4ef947f3db7b43ba078","slotDate":"2026-03-17","slotStart":"2026-03-17T08:30:00.000Z","slotEnd":"2026-03-17T09:30:00.000Z","timezone":"Asia/Kolkata","itemCount":3,"address":"flat 679 gbm appartment greater sahibzada ajit singh nagar gbm appartment 140301","userName":"Aman Upadhyay","userPhone":"+919241867776","venName":"Aman","venPhone":"+917488971473","paymentType":"paid","transactionId":"pay_SSCSnb1V6kfLqD","items":[{"itemId":"69b7c67a7d3b176e6ac56975","categoryName":"Wash & Iron","itemName":"White Shirt","quantity":1,"price":22,"subtotal":22},{"itemId":"69b7c67a7d3b176e6ac56976","categoryName":"Wash & Iron","itemName":"T-Shirt","quantity":1,"price":12,"subtotal":12},{"itemId":"69b7c67a7d3b176e6ac56974","categoryName":"Wash & Iron","itemName":"Shirt","quantity":1,"price":15,"subtotal":15}],"status":"booked","cancellationReason":null,"totalAmount":49,"isDeleted":false,"createdAt":"2026-03-17T06:51:28.000Z"}]}
  ''';
  
  try {
    final model = orderModelFromJson(jsonString);
    print("Parsed successfully. Total amount: \${model.data.first.totalAmount}");
  } catch (e, stacktrace) {
    print("Error parsing: \$e");
    print(stacktrace);
  }
}
