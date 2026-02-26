import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';

class PriceSummaryCard extends StatefulWidget {
  final double subtotal;
  final double pickupCharge;
  final double tax;
  final double total;

  const PriceSummaryCard({
    super.key,
    required this.subtotal,
    required this.pickupCharge,
    required this.tax,
    required this.total,
  });

  @override
  State<PriceSummaryCard> createState() => _PriceSummaryCardState();
}

class _PriceSummaryCardState extends State<PriceSummaryCard> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadowPink,
            blurRadius: 10,
            spreadRadius: -4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Price Summary",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: Icon(
              isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: AppColors.secText,
            ),
            onTap: () {
              setState(() => isOpen = !isOpen);
            },
          ),

          if (isOpen) ...[
            const Divider(
              height: 1,
              thickness: 0.5,
              indent: 15,
              endIndent: 15,
              color: AppColors.secText,
            ),

            _row(context, "Cart Value", widget.subtotal),

            if (widget.pickupCharge > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Add items worth ₹${100 - widget.subtotal} to get free pickup",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),

            _row(context, "Pickup Charge", widget.pickupCharge),
            _row(context, "Taxes", widget.tax),

            const SizedBox(height: 8),
            const Divider(
              color: AppColors.secText,
              thickness: 0.5,
              height: 1,
              indent: 15,
              endIndent: 15,
            ),

            _row(context, "Total", widget.total, bold: true),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _row(
    BuildContext context,
    String label,
    double value, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Text(
            label,
            style:
                bold
                    ? Theme.of(context).textTheme.bodyLarge
                    : Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            "₹ ${value.toStringAsFixed(0)}",
            style:
                bold
                    ? Theme.of(context).textTheme.bodyLarge
                    : Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
