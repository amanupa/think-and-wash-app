import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:think_and_wash/route/app_routes.dart';

import '../../../core/app_colors.dart';
import 'widgets/address_card.dart';
import 'widgets/price_summary_card.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

  bool isSummaryOpen = false;

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CartLoaded) {
          final subtotal = state.subtotal.toDouble();

          final pickupCharge = subtotal < 100 ? 20.0 : 0.0;
          final tax = subtotal * 0.12; // background calc
          final total = subtotal + pickupCharge + tax;
          return Stack(
            children: [
              CustomScrollView(
                key: const PageStorageKey("cart"),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = state.items[index];

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
                          item.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          "Quantity: ${item.quantity}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: Text(
                          "₹ ${item.total}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }, childCount: state.items.length),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 20)),

                  //Address card
                  AddressCard(),

                  //summary card
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: PriceSummaryCard(
                        subtotal: subtotal,
                        pickupCharge: pickupCharge,
                        tax: tax,
                        total: total,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 80)),
                ],
              ),

              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: -2,
                          color: AppColors.boxShadowPink,
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Pay ₹ ${total.toStringAsFixed(0)}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        /// empty state
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/emptyCart.png"),
              const SizedBox(height: 10),
              const Text("Cart is empty, Add item to wash..."),
            ],
          ),
        );
      },
    );
  }
}
