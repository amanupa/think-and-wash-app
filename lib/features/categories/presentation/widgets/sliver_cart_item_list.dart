import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../../core/app_colors.dart';
import '../../data/models/category_item_model.dart';

class SliverCartItemList extends StatelessWidget {
  final List<ProductItem> items;
  final bool iscartbutton;

  const SliverCartItemList({
    super.key,
    required this.items,
    required this.iscartbutton,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = items[index];

        return Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Image
              Container(
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
                height: 50,
                width: 50,
                child: Image.asset(item.image),
              ),

              /// Name
              Text(item.name, style: Theme.of(context).textTheme.titleMedium),

              /// Cart Controls
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  int count = 0;

                  if (state is CartLoaded) {
                    final existing =
                        state.items.where((e) => e.id == item.id).toList();

                    if (existing.isNotEmpty) {
                      count = existing.first.quantity;
                    }
                  }

                  return SizedBox(
                    //width: 187,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<CartBloc>().add(RemoveItem(item.id));
                          },
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.boxShadowPink,
                          ),
                        ),

                        Text("$count"),

                        IconButton(
                          onPressed: () {
                            context.read<CartBloc>().add(
                              AddItem(
                                id: item.id,
                                name: item.name,
                                price: item.price,
                              ),
                            );
                          },
                          icon: Image.asset("assets/bag.png"),
                        ),

                        Text(
                          "₹ ${item.price}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }, childCount: items.length),
    );
  }
}
