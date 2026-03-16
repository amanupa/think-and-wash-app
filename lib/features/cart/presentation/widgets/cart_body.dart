import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/pickupSlot/presentation/slot_selection_container.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/custom_button.dart';
import '../bloc/cart_bloc.dart';
import 'address_card.dart';
import 'price_summary_card.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

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
                          decoration: const BoxDecoration(
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
                          child: Image.asset("assets/cart.png"),
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
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: SlotSelectionSection(
                        vendorId: "69ae5cc549a2b6ad583acc8a",
                      ),
                    ),
                  ),

                  //Address card
                  const AddressCard(),

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
                  const SliverToBoxAdapter(child: SizedBox(height: 80)),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    onpressed: () {},
                    btnTitle: "Pay ₹ ${total.toStringAsFixed(0)}",
                  ),
                ],
              ),
            ],
          );
        }

        /// empty state
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/emptyCart.png", cacheWidth: 600),
              const SizedBox(height: 10),
              const Text("Cart is empty, Add item to wash..."),
            ],
          ),
        );
      },
    );
  }
}
