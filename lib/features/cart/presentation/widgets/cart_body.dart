import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/order/presentation/bloc/orders_bloc.dart';
import 'package:think_and_wash/features/order/presentation/bloc/orders_state.dart';
import 'package:think_and_wash/features/pickupSlot/presentation/slot_selection_container.dart';

import '../../../../core/custom_button.dart';
import '../bloc/cart_bloc.dart';
import '../controllers/cart_action_controller.dart';
import 'address_card.dart';
import 'cart_item_tile.dart';
import 'empty_cart_view.dart';
import 'price_summary_card.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  late final CartActionController _actionController;

  @override
  void initState() {
    super.initState();
    _actionController = CartActionController();
  }

  @override
  void dispose() {
    _actionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener:
          (context, state) =>
              _actionController.onOrderStateChanged(context, state),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final subtotal = state.subtotal.toDouble();
            final pickupCharge = subtotal < 100 ? 20.0 : 0.0;
            final tax = subtotal * 0.12;
            final total = subtotal + pickupCharge + tax;

            return Stack(
              children: [
                CustomScrollView(
                  key: const PageStorageKey("cart"),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return CartItemTile(item: state.items[index]);
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
                    const AddressCard(),
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
                    BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, orderState) {
                        final isLoading = orderState is OrderLoadingState;
                        return CustomButton(
                          onpressed:
                              isLoading
                                  ? () {}
                                  : () => _actionController.onPayPressed(
                                    context,
                                    state,
                                    total - tax - pickupCharge,
                                  ),
                          btnTitle:
                              isLoading
                                  ? "Processing..."
                                  : "Pay ₹ ${total.toStringAsFixed(0)}",
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          }

          return const EmptyCartView();
        },
      ),
    );
  }
}
