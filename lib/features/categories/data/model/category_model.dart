import 'dart:convert';

CategoryItemModel categoryItemModelFromJson(String str) =>
    CategoryItemModel.fromJson(json.decode(str));

String categoryItemModelToJson(CategoryItemModel data) =>
    json.encode(data.toJson());

class CategoryItemModel {
  bool success;
  int count;
  List<Datum> data;

  CategoryItemModel({
    required this.success,
    required this.count,
    required this.data,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) =>
      CategoryItemModel(
        success: json["success"],
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String vendor;
  String categoryName;
  List<Item> items;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.vendor,
    required this.categoryName,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"] ?? "",
    vendor: json["vendor"] ?? "",
    categoryName: json["categoryName"] ?? "",
    items:
        json["items"] != null
            ? List<Item>.from(json["items"].map((x) => Item.fromJson(x)))
            : [],
    createdAt:
        json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
    updatedAt:
        json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "vendor": vendor,
    "categoryName": categoryName,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Item {
  String name;
  String image;
  int price;
  String id;

  Item({
    required this.name,
    required this.image,
    required this.price,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"] ?? "",
    image: json["image"] ?? "",
    price: json["price"] ?? 0,
    id: json["_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "price": price,
    "_id": id,
  };
}
