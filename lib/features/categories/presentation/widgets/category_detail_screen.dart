import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/core/custom_circular_button.dart';
import 'package:think_and_wash/features/categories/data/model/category_model.dart';
import 'package:think_and_wash/features/categories/presentation/widgets/sliver_cart_item_list.dart';
import 'package:think_and_wash/route/app_routes.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String title;
  final List<Item> items;

  const CategoryDetailScreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.background,
                title: Text(title),
                centerTitle: true,
                pinned: true,
              ),
              SliverCartItemList(items: items, iscartbutton: true),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
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
