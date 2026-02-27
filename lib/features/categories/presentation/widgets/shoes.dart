import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/features/categories/data/datasource/local/wash_iron_data_source.dart';
import 'package:think_and_wash/features/categories/presentation/widgets/sliver_cart_item_list.dart';

import '../../../../core/custom_circular_button.dart';
import '../../../../route/app_routes.dart';

class Shoes extends StatelessWidget {
  const Shoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.background,
                title: Text("Shoes Cleaning"),
                centerTitle: true,
                pinned: true,
              ),
              SliverCartItemList(
                items: CategoryProductItems.shoesItems,
                iscartbutton: true,
              ),
            ],
          ),
          CustomCircularButton(
            onpressed: () {
              Navigator.pushNamed(context, AppRoutes.cart);
            },
            btnTitle: "Cart",
          ),
        ],
      ),
    );
  }
}
