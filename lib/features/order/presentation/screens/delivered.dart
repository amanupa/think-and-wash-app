import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/order.dart';

import '../bloc/orders_bloc.dart';
import '../bloc/orders_state.dart';
import '../widgets/order_card.dart';

class Delivered extends StatelessWidget {
  const Delivered({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderInitialState || state is OrderLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetOrderSuccessState) {
          final orders =
              state.orders.data
                  .where((e) => e.status == OrdersStatus.delivery)
                  .toList();

          if (orders.isEmpty) {
            return const Center(
              child: Text("No order or about to deliver your order"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderCard(order: order);
            },
          );
        }
        if (state is GetOrderFailureState) {
          return Center(child: Text(state.msg));
        }
        return const Center(child: Text("We love to wash, we are waiting..."));
      },
    );
  }
}
