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
          return Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: -4,
                            offset: Offset(0, 5),
                            color: AppColors.boxShadowPink,
                          ),
                        ],
                      ),

                      child: Image.asset("assets/bag.png"),
                    ),
                    title: Text(
                      state.items[index].name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      "Quantity: ${state.items[index].quantity}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: Text(
                      "₹ ${state.items[index].total.toString()}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,

                              spreadRadius: -2,
                              offset: Offset(0, 0),
                              color: AppColors.boxShadowPink,
                            ),
                          ],
                          color: AppColors.background,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Pay ₹ ${state.subtotal}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
