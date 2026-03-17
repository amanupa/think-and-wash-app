import 'package:flutter/material.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/emptyCart.png", cacheWidth: 600),
          const SizedBox(height: 10),
          const Text("Cart is empty, Add item to wash..."),
        ],
      ),
    );
  }
}
