import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/features/categories/data/datasource/local/wash_iron_data_source.dart';
import 'package:think_and_wash/features/categories/presentation/widgets/sliver_cart_item_list.dart';

class DryClean extends StatelessWidget {
  const DryClean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.background,
            title: Text("Dry Cleaning"),
            centerTitle: true,
            pinned: true,
          ),
          SliverCartItemList(items: dryCleanItems),
        ],
      ),
    );
  }
}
