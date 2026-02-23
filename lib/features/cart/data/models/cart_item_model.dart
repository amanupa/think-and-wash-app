class CartItem {
  final int id;
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  CartItem increase() {
    return CartItem(id: id, name: name, price: price, quantity: quantity + 1);
  }

  CartItem decrease() {
    return CartItem(id: id, name: name, price: price, quantity: quantity - 1);
  }

  double get total => price * quantity;
}
