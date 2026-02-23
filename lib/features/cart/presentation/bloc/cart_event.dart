part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddItem extends CartEvent {
  final int id;
  final String name;
  final double price;

  AddItem({required this.id, required this.name, required this.price});
}

class RemoveItem extends CartEvent {
  final int id;

  RemoveItem(this.id);
}

class ClearCart extends CartEvent {}
