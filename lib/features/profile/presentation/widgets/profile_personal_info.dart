import 'package:flutter/material.dart';
import 'package:think_and_wash/core/custom_drop_down.dart';
import 'package:think_and_wash/core/custom_input_fields.dart';

class ProfilePersonalInfo extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final ValueNotifier<String?> genderNotifier;
  final bool isEditMode;

  const ProfilePersonalInfo({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.genderNotifier,
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
        _sectionTitle(context, "Personal Information"),
        const SizedBox(height: 15),
        CustomInputField(
          controller: firstNameController,
          hint: "First Name",
          enabled: isEditMode,
          validator: (value) => value!.isEmpty ? "Enter first name" : null,
        ),
        const SizedBox(height: 15),
        CustomInputField(
          controller: lastNameController,
          hint: "Last Name",
          enabled: isEditMode,
          validator: (value) => value!.isEmpty ? "Enter last name" : null,
        ),
        const SizedBox(height: 15),
        CustomInputField(
          controller: emailController,
          hint: "Email",
          enabled: isEditMode,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) return "Enter email";
            if (!value.contains("@")) return "Enter valid email";
            return null;
          },
        ),
        const SizedBox(height: 15),
        ValueListenableBuilder<String?>(
          valueListenable: genderNotifier,
          builder: (context, value, _) {
            return CustomDropdownField(
              value: value,
              hint: "Select Gender",
              items: const ["Male", "Female"],
              onChanged: (val) {
                if (isEditMode) {
                  genderNotifier.value = val;
                }
              },
            );
          },
        ),
      ],
    );
  }
}
