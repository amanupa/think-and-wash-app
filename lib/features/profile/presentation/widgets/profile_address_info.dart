import 'package:flutter/material.dart';
import 'package:think_and_wash/core/custom_input_fields.dart';
import 'package:think_and_wash/core/custom_tool_tip.dart';

class ProfileAddressInfo extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController landmarkController;
  final TextEditingController pincodeController;
  final bool isEditMode;

  const ProfileAddressInfo({
    super.key,
    required this.addressController,
    required this.landmarkController,
    required this.pincodeController,
    required this.isEditMode,
  });

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _sectionTitle(context, "Address"),
            const SizedBox(width: 6),
            const CustomInfoTooltip(
              message: "This address will be used as pickup and delivery address.",
            ),
          ],
        ),
        const SizedBox(height: 15),
        CustomInputField(
          controller: addressController,
          enabled: isEditMode,
          hint: "Full Address (max 10 words)",
          validator: (value) {
            if (value!.isEmpty) return "Enter address";
            if (value.split(" ").length > 10) {
              return "Maximum 10 words allowed";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        CustomInputField(
          controller: landmarkController,
          enabled: isEditMode,
          hint: "Nearby / Landmark",
        ),
        const SizedBox(height: 15),
        CustomInputField(
          controller: pincodeController,
          enabled: isEditMode,
          hint: "Pincode",
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.length != 6) {
              return "Pincode must be exactly 6 digits";
            }
            return null;
          },
        ),
      ],
    );
  }
}
