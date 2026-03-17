import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../../core/app_colors.dart';
import '../../data/model/category_model.dart';

class SliverCartItemList extends StatelessWidget {
  final List<Item> items;
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
                height: 50,
                width: 50,
                child: Image.network(
                  item.image,
                  cacheHeight: 150,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),

              Text(item.name, style: Theme.of(context).textTheme.titleMedium),

              BlocSelector<CartBloc, CartState, int>(
                selector: (state) {
                  if (state is CartLoaded) {
                    final existing =
                        state.items.where((e) => e.id == item.id).toList();
                    if (existing.isNotEmpty) {
                      return existing.first.quantity;
                    }
                  }
                  return 0;
                },
                builder: (context, count) {
                  return SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<CartBloc>().add(RemoveItem(item.id));
                          },
                          icon: const Icon(
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
