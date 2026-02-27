import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import 'widgets/cart_body.dart';

class Cart extends StatelessWidget {
  final bool istab;
  const Cart({super.key, required this.istab});

  final bool isSummaryOpen = false;

  @override
  Widget build(BuildContext context) {
    return istab
        ? CartBody()
        : Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.background,
            title: Text(
              "Your Cart",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
          ),
          body: CartBody(),
        );
  }
}
