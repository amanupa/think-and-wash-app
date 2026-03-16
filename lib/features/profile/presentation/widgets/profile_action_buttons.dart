import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';
import 'package:think_and_wash/core/custom_button.dart';

class ProfileActionButtons extends StatelessWidget {
  final bool isEditMode;
  final VoidCallback onEditPressed;
  final VoidCallback onUpdatePressed;

  const ProfileActionButtons({
    super.key,
    required this.isEditMode,
    required this.onEditPressed,
    required this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return isEditMode
        ? CustomButton(
            onpressed: onUpdatePressed,
            btnTitle: "Update Profile",
          )
        : Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(17),
                ),
                border: Border.all(color: AppColors.seedColor),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: -1,
                    blurRadius: 10,
                    offset: Offset(3, 5),
                    color: AppColors.boxShadowPink,
                  ),
                ],
              ),
              child: FloatingActionButton(
                backgroundColor: AppColors.background,
                elevation: 0,
                onPressed: onEditPressed,
                child: const Icon(Icons.edit, color: AppColors.button),
              ),
            ),
          );
  }
}
