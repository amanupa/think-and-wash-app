import 'dart:convert';

PickupSlotModel pickupSlotModelFromJson(String str) =>
    PickupSlotModel.fromJson(json.decode(str));

String pickupSlotModelToJson(PickupSlotModel data) =>
    json.encode(data.toJson());

class PickupSlotModel {
  bool success;
  List<PickUpSlot> data;

  PickupSlotModel({required this.success, required this.data});

  factory PickupSlotModel.fromJson(Map<String, dynamic> json) =>
      PickupSlotModel(
        success: json["success"],
        data: List<PickUpSlot>.from(
          json["data"].map((x) => PickUpSlot.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PickUpSlot {
  String id;
  DateTime start;
  DateTime end;
  int availableCapacity;

  PickUpSlot({
    required this.id,
    required this.start,
    required this.end,
    required this.availableCapacity,
  });

  factory PickUpSlot.fromJson(Map<String, dynamic> json) => PickUpSlot(
    id: json["id"],
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
    availableCapacity: json["availableCapacity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start": start.toIso8601String(),
    "end": end.toIso8601String(),
    "availableCapacity": availableCapacity,
  };
}
