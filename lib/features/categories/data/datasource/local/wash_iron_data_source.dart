import '../../models/category_item_model.dart';

class CategoryProductItems {
  static final List<ProductItem> washItems = const [
    ProductItem(id: 1, name: "Shirt", price: 15, image: "assets/shirt.png"),
    ProductItem(
      id: 2,
      name: "White Shirt",
      price: 22,
      image: "assets/white-sh.png",
    ),
    ProductItem(id: 3, name: "T-Shirt", price: 12, image: "assets/t-shirt.png"),
    ProductItem(
      id: 4,
      name: "Formal Pant",
      price: 20,
      image: "assets/formal_pant.png",
    ),
    ProductItem(id: 5, name: "White Pant", price: 27, image: ""),
    ProductItem(id: 6, name: "Jeans", price: 20, image: "assets/jeans.png"),
    ProductItem(id: 7, name: "Lower / Trouser", price: 18, image: ""),
    ProductItem(id: 8, name: "Hoodie", price: 30, image: "assets/hoodie.png"),
    ProductItem(id: 9, name: "Kurti", price: 40, image: "assets/kurti.png"),
    ProductItem(id: 10, name: "Shorts", price: 15, image: "assets/shorts.png"),
    ProductItem(
      id: 11,
      name: "Towel / Dupatta",
      price: 20,
      image: "assets/towel-dupatta.png",
    ),
    ProductItem(
      id: 12,
      name: "Coat / Blazer",
      price: 65,
      image: "assets/coat_blazer.png",
    ),
    ProductItem(id: 13, name: "Simple Saree", price: 50, image: ""),
  ];

  static final List<ProductItem> premium = const [
    ProductItem(
      id: 101,
      name: "Blazer / Coat",
      price: 120,
      image: "assets/coat_blazer.png",
    ),
    ProductItem(id: 102, name: "Leather Jacket", price: 200, image: ""),
    ProductItem(id: 103, name: "Party Jacket", price: 200, image: ""),
    ProductItem(id: 104, name: "Lehenga Simple", price: 250, image: ""),
    ProductItem(id: 105, name: "Sherwani", price: 200, image: ""),
    ProductItem(id: 106, name: "Lehenga Heavy", price: 350, image: ""),
    ProductItem(id: 107, name: "Heavy Saree", price: 200, image: ""),
    ProductItem(id: 108, name: "P-Shirt", price: 50, image: "assets/shirt.png"),
    ProductItem(
      id: 109,
      name: "Sneakers",
      price: 200,
      image: "assets/p-sneaker.png",
    ),
  ];

  static final List<ProductItem> homeBounds = const [
    ProductItem(
      id: 201,
      name: "BedSheet",
      price: 35,
      image: "assets/bedsheet.webp",
    ),
    ProductItem(id: 202, name: "Blanket (W<3kg)", price: 200, image: ""),
    ProductItem(id: 203, name: "Curtains", price: 80, image: ""),
    ProductItem(id: 204, name: "Pillow Cover", price: 25, image: ""),
    ProductItem(id: 205, name: "Fridge Cover", price: 40, image: ""),
    ProductItem(id: 206, name: "Blanket (W>=3kg)", price: 300, image: ""),
  ];

  static final List<ProductItem> shoesItems = const [
    ProductItem(
      id: 301,
      name: "Leather Shoes",
      price: 120,
      image: "assets/l-shoes.png",
    ),
    ProductItem(
      id: 302,
      name: "Sneakers",
      price: 100,
      image: "assets/sneaker.png",
    ),
    ProductItem(
      id: 303,
      name: "Sports Shoes",
      price: 80,
      image: "assets/shoe.png",
    ),
    ProductItem(
      id: 304,
      name: "Leather Boot",
      price: 150,
      image: "assets/l-boot.png",
    ),
    ProductItem(
      id: 305,
      name: "Leather Chelsea",
      price: 170,
      image: "assets/chelsea.png",
    ),
  ];

  static final List<ProductItem> bagItems = const [
    ProductItem(id: 401, name: "Backpack", price: 110, image: ""),
    ProductItem(id: 402, name: "Gym Bag", price: 120, image: ""),
    ProductItem(id: 403, name: "Leather Bag", price: 160, image: ""),
    ProductItem(id: 404, name: "Traveller Bag", price: 180, image: ""),
    ProductItem(id: 405, name: "Traveller L-Bag", price: 350, image: ""),
  ];

  static final List<ProductItem> dryCleanItems = const [
    ProductItem(
      id: 501,
      name: "DC-Shirt",
      price: 25,
      image: "assets/shirt.png",
    ),
    ProductItem(id: 502, name: "DC-White Shirt", price: 30, image: ""),
    ProductItem(
      id: 503,
      name: "DC-T-Shirt",
      price: 20,
      image: "assets/t-shirt.png",
    ),
    ProductItem(
      id: 504,
      name: "DC-Formal Pant",
      price: 28,
      image: "assets/formal_pant.png",
    ),
    ProductItem(id: 505, name: "DC-Simple Saree", price: 38, image: ""),
    ProductItem(
      id: 506,
      name: "DC-Jeans",
      price: 30,
      image: "assets/jeans.png",
    ),
    ProductItem(
      id: 507,
      name: "DC-Hoody",
      price: 45,
      image: "assets/hoodie.png",
    ),
    ProductItem(
      id: 508,
      name: "DC-Coat / Blazer",
      price: 80,
      image: "assets/coat_blazer.png",
    ),
  ];
}
