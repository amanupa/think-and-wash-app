part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;

  final num subtotal;
  final num tax;
  final num total;

  CartLoaded({
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.total,
  });
}

class CartEmpty extends CartState {}
