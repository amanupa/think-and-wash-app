import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../core/app_colors.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is CartLoaded) {
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset("assets/bag.png"),
                title: Text(
                  state.items[index].name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  "Quantity: ${state.items[index].quantity}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Text(
                  state.items[index].total.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            },
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,

                    spreadRadius: 4,
                    offset: Offset(200, 8),
                    color: AppColors.boxShadowPink,
                  ),
                ],
              ),
              child: Image.asset("assets/emptyCart.png"),
            ),
            Text(
              "Cart is empty, Add item to wash...",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        );
      },
    );
  }
}
