part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddItem extends CartEvent {
  final String id;
  final String name;
  final int price;

  AddItem({required this.id, required this.name, required this.price});
}

class RemoveItem extends CartEvent {
  final String id;

  RemoveItem(this.id);
}

class ClearCart extends CartEvent {}
