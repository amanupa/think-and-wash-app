import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class OrderTracking extends StatelessWidget {
  final int currentStep;

  const OrderTracking({super.key, required this.currentStep});

  static const titles = [
    "Order Confirmed",
    "Picked Up",
    "Washing",
    "Out for Delivery",
    "Delivered",
  ];

  static const icons = [
    Icons.receipt_long,
    Icons.shopping_bag,
    Icons.local_laundry_service,
    Icons.delivery_dining,
    Icons.emoji_events,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: List.generate(titles.length, (index) {
            final isDone = index < currentStep;
            final isActive = index == currentStep;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    _circle(isDone, isActive, index),
                    if (index != titles.length - 1)
                      Container(
                        width: 4,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors:
                                isDone
                                    ? [
                                      AppColors.boxShadowblue,
                                      Colors.greenAccent,
                                    ]
                                    : [
                                      Colors.grey.shade300,
                                      Colors.grey.shade200,
                                    ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _card(isDone, isActive, titles[index], context),
                ),
              ],
            );
          }),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.39,
              width: MediaQuery.of(context).size.width * 0.99,
              child: Image.asset(
                "assets/india.png",
                fit: BoxFit.contain,
                alignment: Alignment.bottomRight,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              //height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.18,
              child: Image.asset("assets/track-order.png", fit: BoxFit.contain),
            ),
          ],
        ),
      ],
    );
  }

  Widget _circle(bool done, bool active, int index) {
    if (done) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 206, 247, 208),
              blurRadius: 12,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.greenAccent,
          child: Center(child: Icon(Icons.check, color: Colors.white)),
        ),
      ); /*const CircleAvatar(
        radius: 16,
        backgroundColor: Color.fromARGB(255, 114, 229, 168),
        child: Icon(Icons.check, color: Colors.white),
      );*/
    }

    if (active) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.orange.withOpacity(.6), blurRadius: 12),
          ],
        ),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.orange,
          child: Center(child: Icon(icons[index], color: Colors.white)),
        ),
      );
    }

    return const CircleAvatar(
      radius: 16,
      backgroundColor: Colors.grey,
      child: Center(child: Icon(Icons.lock, color: Colors.white)),
    );
  }

  Widget _card(bool done, bool active, String title, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        boxShadow: [
          done
              ? BoxShadow(
                blurRadius: 10,
                spreadRadius: -5,
                offset: Offset(4, 5),
                color: AppColors.boxShadowPink,
              )
              : active
              ? BoxShadow(
                blurRadius: 12,
                spreadRadius: -4,
                offset: Offset(3, 3),
                color: Colors.orange.withOpacity(.6),
                //blurRadius: 12,
              )
              : BoxShadow(
                blurRadius: 8,
                spreadRadius: -4,
                offset: Offset(3, 3),
                color: AppColors.boxShadowblue,
              ),
        ],

        borderRadius: BorderRadius.circular(14),
        color:
            done
                ? AppColors.background
                : active
                ? Colors.orange
                : Colors.grey.shade100,
      ),
      child: Text(title, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
