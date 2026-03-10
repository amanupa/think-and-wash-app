import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_colors.dart';
import '../../data/model/order.dart';

class OrderDetails extends StatelessWidget {
  final Datum order;

  const OrderDetails({super.key, required this.order});

  String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time.toLocal());
  }

  String formatDate(DateTime date) {
    // final parsed = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Order Details",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ORDER STATUS
            _SectionCard(
              child: Column(
                children: [
                  Text(
                    order.status.toString().toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Order ID : ${order.id}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// CUSTOMER INFO
            _SectionCard(
              title: "Customer",
              child: Column(
                children: [
                  _InfoRow("Name", order.userName),
                  _InfoRow("Phone", order.userPhone),
                  _InfoRow("Address", order.address),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// VENDOR INFO
            _SectionCard(
              title: "Vendor",
              child: Column(
                children: [
                  _InfoRow("Name", order.venName),
                  _InfoRow("Phone", order.venPhone),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// PICKUP SLOT
            _SectionCard(
              title: "Pickup Slot",
              child: Column(
                children: [
                  _InfoRow("Date", formatDate(order.slotDate!)),
                  _InfoRow(
                    "Time",
                    "${formatTime(order.slotStart!)} - ${formatTime(order.slotEnd!)}",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// ITEMS
            _SectionCard(
              title: "Items",
              child: Column(
                children:
                    order.items.map((item) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.boxShadowPink,
                              blurRadius: 6,
                              spreadRadius: -1,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.itemName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.categoryName,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("x${item.quantity}"),
                                Text("₹${item.subtotal}"),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            /// PAYMENT
            _SectionCard(
              title: "Payment",
              child: Column(
                children: [
                  _InfoRow("Method", order.paymentType.toUpperCase()),
                  _InfoRow("Total", "₹${order.totalAmount}"),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String? title;
  final Widget child;

  const _SectionCard({this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.seedColor),
          left: BorderSide(color: AppColors.seedColor),
          bottom: BorderSide(color: AppColors.seedColor),
        ),
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: AppColors.boxShadowPink,
            blurRadius: 8,
            spreadRadius: -4,
            offset: Offset(3, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
          ],
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
