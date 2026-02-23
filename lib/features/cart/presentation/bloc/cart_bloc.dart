import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cart_item_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem> _items = [];

  CartBloc() : super(CartInitial()) {
    on<AddItem>(_add);
    on<RemoveItem>(_remove);
    on<ClearCart>(_clear);
  }

  void _add(AddItem event, Emitter<CartState> emit) {
    final index = _items.indexWhere((e) => e.id == event.id);

    if (index == -1) {
      _items.add(
        CartItem(
          id: event.id,
          name: event.name,
          price: event.price,
          quantity: 1,
        ),
      );
    } else {
      _items[index] = _items[index].increase();
    }

    _emitLoaded(emit);
  }

  void _remove(RemoveItem event, Emitter<CartState> emit) {
    final index = _items.indexWhere((e) => e.id == event.id);

    if (index == -1) return;

    final item = _items[index];

    if (item.quantity == 1) {
      _items.removeAt(index);
    } else {
      _items[index] = item.decrease();
    }

    if (_items.isEmpty) {
      emit(CartEmpty());
    } else {
      _emitLoaded(emit);
    }
  }

  void _clear(ClearCart event, Emitter<CartState> emit) {
    _items.clear();
    emit(CartEmpty());
  }

  // PRICE ENGINE
  void _emitLoaded(Emitter<CartState> emit) {
    final subtotal = _items.fold(0.0, (sum, e) => sum + e.total);

    const taxRate = 0.05;
    final tax = subtotal * taxRate;
    final total = subtotal + tax;

    emit(
      CartLoaded(
        items: List.from(_items),
        subtotal: subtotal,
        tax: tax,
        total: total,
      ),
    );
  }
}
