import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/order/domain/entity/create_order_entity.dart';
import 'package:think_and_wash/features/order/presentation/bloc/orders_bloc.dart';
import 'package:think_and_wash/features/order/presentation/bloc/orders_event.dart';
import 'package:think_and_wash/features/order/presentation/bloc/orders_state.dart';
import 'package:think_and_wash/features/payment/presentation/payment_service.dart';
import 'package:think_and_wash/features/pickupSlot/presentation/bloc/pick_up_slot_bloc.dart';
import 'package:think_and_wash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:think_and_wash/route/app_routes.dart';

import '../../../../core/snack_bar_messages.dart';
import '../bloc/cart_bloc.dart';

class CartActionController {
  late final RazorpayService _razorpayService;

  CartActionController() {
    _razorpayService = RazorpayService();
  }

  void dispose() {
    _razorpayService.dispose();
  }

  void onPayPressed(BuildContext context, CartLoaded cartState, double total) {
    // 1. Validate pickup slot
    final slotState = context.read<PickUpSlotBloc>().state;
    if (slotState is! UserSlotLoaded || slotState.selectedSlot == null) {
      SnackbarService.info("Please select a pickup slot");
      return;
    }

    // 2. Validate address
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is! ProfileUpdateSuccessState ||
        profileState.usr.address == null) {
      SnackbarService.info("Please update your address in profile");
      return;
    }

    // 3. Open Razorpay checkout
    final amountInPaise = (total * 100).toInt();

    _razorpayService.openCheckout(
      amount: amountInPaise,
      email: profileState.usr.email!,
      contact: profileState.usr.phone!,
      onSuccess: (transactionId) {
        _createOrder(
          context: context,
          cartState: cartState,
          total: total,
          transactionId: transactionId,
          slotId: slotState.selectedSlot!.id,
          address:
              "${profileState.usr.address} ${profileState.usr.landmark ?? ''} ${profileState.usr.pincode ?? ''}",
        );
      },
      onError: (message) {
        SnackbarService.error(message);
      },
    );
  }

  void _createOrder({
    required BuildContext context,
    required CartLoaded cartState,
    required double total,
    required String transactionId,
    required String slotId,
    required String address,
  }) {
    final items =
        cartState.items
            .map((e) => OrderItemEntity(id: e.id, count: e.quantity))
            .toList();

    final entity = CreateOrderEntity(
      vendorId: "69ae5cc549a2b6ad583acc8a",
      pickupSlotId: slotId,
      items: items,
      address: address.trim(),
      paymentType: PaymentType.paid,
      totalAmount: total.toInt(),
      transactionId: transactionId,
    );

    context.read<OrderBloc>().add(CreateOrderEvent(entity: entity));
  }

  void onOrderStateChanged(BuildContext context, OrderState state) {
    if (state is CreateOrderSuccessState) {
      debugPrint("inside success state on order change function");
      // Clear cart and navigate to home
      context.read<CartBloc>().add(ClearCart());
      SnackbarService.success("Order placed successfully!");

      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
    } else if (state is CreateOrderFailureState) {
      debugPrint("inside failure state on order change function");
      SnackbarService.error(state.msg);
    } else if (state is OrderServerFailureState) {
      debugPrint("inside server failure state on order change function");
      SnackbarService.error(state.msg);
    }
  }
}
