import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:think_and_wash/features/order/data/model/order.dart';

import '../../../../core/app_colors.dart';

class OrderCard extends StatelessWidget {
  final Datum order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(color: AppColors.seedColor),
          left: BorderSide(color: AppColors.seedColor),
        ),
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: -5,
            offset: Offset(2, 5),
            color: AppColors.boxShadowPink,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Name + Phone
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Vendor: ${order.venName}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                order.venPhone,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Address
          Text(
            "Pickup: ${order.address}",
            style: Theme.of(context).textTheme.titleSmall,
          ),

          const SizedBox(height: 8),

          /// Total Items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Items: ${order.itemCount}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "Pickup Time: ${formatTime(order.slotStart!)}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Payment + Order Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "₹ ${order.totalAmount.toStringAsFixed(0)}  ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    order.paymentType,
                    style: TextStyle(
                      color:
                          order.paymentType == "cod"
                              ? Colors.orange
                              : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "Pickup Date: ${order.slotDate!.toLocal().toString().split(' ')[0]}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time.toLocal());
  }
}
