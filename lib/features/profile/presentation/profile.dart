import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/custom_button.dart';
import 'package:think_and_wash/core/snack_bar_messages.dart';
import 'package:think_and_wash/features/profile/domain/profile_entity.dart';
import 'package:think_and_wash/features/profile/presentation/bloc/profile_bloc.dart';

import '../../../core/app_colors.dart';

import '../../../core/custom_drop_down.dart';
import '../../../core/custom_input_fields.dart';
import '../../../core/custom_tool_tip.dart';
import '../../auth/data/auth_model.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  sectionTitle(BuildContext context, String title) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController pincode = TextEditingController();

  String? gender;
  bool isEditMode = false;
  bool isFirstTimeUser = false;
  void initializeUser(User user) {
    final parts = user.name?.split(" ") ?? [];

    firstName.text = parts.isNotEmpty ? parts.first : "";
    lastName.text = parts.length > 1 ? parts.sublist(1).join(" ") : "";

    email.text = user.email ?? "";
    address.text = user.address ?? "";
    landmark.text = user.landmark ?? "";
    pincode.text = user.pincode ?? "";

    gender =
        user.gender != null
            ? user.gender![0].toUpperCase() + user.gender!.substring(1)
            : null;

    if (user.email == null || user.email!.isEmpty) {
      isFirstTimeUser = true;
      isEditMode = true;
    }
  }

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;

    if (authState is OtpValidationSuccess) {
      final user = authState.userMOdel;

      if (user != null) {
        initializeUser(user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileInitial) {
          final authState = context.read<AuthBloc>().state;

          if (authState is OtpValidationSuccess) {
            final user = authState.userMOdel;
            debugPrint("user: $user");

            if (user != null) {
              initializeUser(user);
            }
          }
        }
        if (state is ProfileUpdateSuccessState) {
          initializeUser(state.usr);
          setState(() {
            isEditMode = false;
          });
          context.read<AuthBloc>().add(UpdateUser(user: state.usr));

          SnackbarService.success("Successfully profile updated");
        }

        if (state is ProfileUpdateFailureState) {
          SnackbarService.error("Failled to update profile");
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text("Profile", style: Theme.of(context).textTheme.titleLarge),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// PERSONAL INFO
                    sectionTitle(context, "Personal Information"),

                    const SizedBox(height: 15),

                    CustomInputField(
                      controller: firstName,
                      hint: "First Name",
                      enabled: isEditMode,

                      validator:
                          (value) => value!.isEmpty ? "Enter first name" : null,
                    ),

                    const SizedBox(height: 15),

                    CustomInputField(
                      controller: lastName,
                      hint: "Last Name",
                      enabled: isEditMode,
                      validator:
                          (value) => value!.isEmpty ? "Enter last name" : null,
                    ),

                    const SizedBox(height: 15),

                    CustomInputField(
                      controller: email,
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

                    CustomDropdownField(
                      value: gender,
                      hint: "Select Gender",

                      items: const ["Male", "Female"],
                      onChanged: (val) => setState(() => gender = val),
                    ),

                    const SizedBox(height: 30),

                    /// ADDRESS SECTION
                    Row(
                      children: [
                        sectionTitle(context, "Address"),
                        const SizedBox(width: 6),
                        const CustomInfoTooltip(
                          message:
                              "This address will be used as pickup and delivery address.",
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    CustomInputField(
                      controller: address,
                      enabled: isEditMode,
                      hint: "Full Address (max 20 words)",
                      //maxLines: 3,
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
                      controller: landmark,
                      enabled: isEditMode,
                      hint: "Nearby / Landmark",
                    ),

                    const SizedBox(height: 15),

                    CustomInputField(
                      controller: pincode,
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

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isEditMode)
                  CustomButton(
                    onpressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ProfileBloc>().add(
                          ProfileUpdateRequestedEvent(
                            entity: ProfileEntity(
                              name: "${firstName.text} ${lastName.text}",
                              email: email.text,
                              gender: gender!.toLowerCase(),
                              fullAddress: address.text,
                              landmark: landmark.text,
                              pincode: pincode.text,
                            ),
                          ),
                        );
                        debugPrint("Profile Updated");
                      }
                    },
                    btnTitle: "Update Profile ",
                  ),
              ],
            ),
          ],
        ),

        floatingActionButton:
            !isEditMode
                ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                    border: Border.all(color: AppColors.seedColor),
                    boxShadow: [
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

                    onPressed: () {
                      setState(() {
                        isEditMode = true;
                      });
                    },
                    child: const Icon(Icons.edit, color: AppColors.button),
                  ),
                )
                : null,
      ),
    );
  }
}
