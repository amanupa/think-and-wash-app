import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';

class OtpTextFieldForm extends StatelessWidget {
  final TextEditingController formController;
  final String buttonText;
  final String page;
  final String hintText;
  final bool isLoading;
  final VoidCallback onPressed;
  OtpTextFieldForm({
    super.key,
    required this.buttonText,
    required this.formController,
    required this.hintText,
    required this.isLoading,
    required this.onPressed,
    required this.page,
  });
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Container(
          height: 450,
          width: 380,

          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: -10,
                offset: Offset(10, 10),
                color: AppColors.boxShadowblue,
              ),
              BoxShadow(
                blurRadius: 10,
                spreadRadius: -10,
                offset: Offset(-10, -10),
                color: AppColors.boxShadowPink,
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/user-login.png",
                    fit: BoxFit.cover,
                    height: 300,
                    width: 350,
                  ),
                ],
              ),
              Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      // width: 250,
                      height: 45,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: -10,
                            offset: Offset(10, 10),
                            color: AppColors.boxShadowPink,
                          ),
                        ],
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: formController,
                          validator:
                              page != "Otp"
                                  ? (value) {
                                    if (value == null || value.length < 6) {
                                      return "OTP must be 6 digits";
                                    }
                                    return null;
                                  }
                                  : (value) {
                                    if (value == null || value.length < 10) {
                                      return "Phone number must be 10 digits";
                                    }
                                    return null;
                                  },
                          style: Theme.of(context).textTheme.bodyMedium,

                          keyboardType:
                              page != "Otp"
                                  ? TextInputType.number
                                  : TextInputType.phone,
                          maxLength: page != "Otp" ? 6 : 10,
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: 200,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          foregroundColor: AppColors.background,
                          shadowColor: AppColors.boxShadowblue,
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed:
                            isLoading
                                ? null
                                : () {
                                  if (_formKey.currentState!.validate()) {
                                    onPressed();
                                  }
                                },
                        child:
                            isLoading
                                ? const CircularProgressIndicator()
                                : Text(buttonText),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
