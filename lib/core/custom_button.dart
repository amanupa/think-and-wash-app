import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String btnTitle;
  final VoidCallback onpressed;
  const CustomButton({
    super.key,
    required this.onpressed,
    required this.btnTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.seedColor),
            color: AppColors.background,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: -2,
                color: AppColors.boxShadowPink,
              ),
            ],
          ),
          child: TextButton(
            onPressed: onpressed, //"Pay ₹ ${total.toStringAsFixed(0)}"
            child: Text(
              btnTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
