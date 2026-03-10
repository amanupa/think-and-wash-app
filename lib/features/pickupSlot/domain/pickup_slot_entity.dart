import 'dart:convert';

class PickupSlotEntity {
  final String date;
  final String vId;

  PickupSlotEntity({required this.date, required this.vId});
  String pickUpSlotModelToJson(PickupSlotEntity entity) =>
      json.encode(entity.toJson());
  Map<String, dynamic> toJson() => {"date": date, "vendorId": vId};
}
