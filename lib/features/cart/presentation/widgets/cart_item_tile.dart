import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../data/models/cart_item_model.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
  }
}
