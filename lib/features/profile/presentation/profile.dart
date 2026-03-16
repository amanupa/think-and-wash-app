import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/snack_bar_messages.dart';
import 'package:think_and_wash/features/profile/domain/profile_entity.dart';
import 'package:think_and_wash/features/profile/presentation/bloc/profile_bloc.dart';

import '../../../core/app_colors.dart';
import '../../auth/data/auth_model.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import 'widgets/profile_action_buttons.dart';
import 'widgets/profile_address_info.dart';
import 'widgets/profile_personal_info.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final ValueNotifier<String?> genderNotifier = ValueNotifier(null);

  bool isEditMode = false;
  bool isFirstTimeUser = false;

  @override
  void initState() {
    super.initState();
    _loadInitialUser();
  }

  /// Loads user data on first launch or persistent login.
  void _loadInitialUser() {
    // 1. Check if ProfileBloc already has the user data (e.g. from HomeScreen init)
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileUpdateSuccessState) {
      _initializeUser(profileState.usr);
      return;
    }

    // 2. Fallback to AuthBloc for first-time login flow
    final authState = context.read<AuthBloc>().state;
    if (authState is OtpValidationSuccess) {
      _initializeUser(authState.userMOdel);
    }
  }

  /// Populates all form fields from a [User] object.
  void _initializeUser(User user) {
    final parts = user.name?.split(" ") ?? [];

    firstName.text = parts.isNotEmpty ? parts.first : "";
    lastName.text = parts.length > 1 ? parts.sublist(1).join(" ") : "";

    email.text = user.email ?? "";
    address.text = user.address ?? "";
    landmark.text = user.landmark ?? "";
    pincode.text = user.pincode ?? "";

    genderNotifier.value =
        user.gender != null
            ? user.gender![0].toUpperCase() + user.gender!.substring(1)
            : null;

    if (user.email == null || user.email!.isEmpty) {
      isFirstTimeUser = true;
      isEditMode = true;
    }
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    address.dispose();
    landmark.dispose();
    pincode.dispose();
    genderNotifier.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccessState) {
          _initializeUser(state.usr);
          setState(() {
            isEditMode = false;
          });
          SnackbarService.success("Successfully updated profile");
        }

        if (state is ProfileUpdateFailureState) {
          SnackbarService.error(state.msg);
        }

        if (state is ProfileUpdateServerFailureState) {
          SnackbarService.error(state.msg);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text("Profile", style: Theme.of(context).textTheme.titleLarge),
          centerTitle: true,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileUpdateFailureState) {
              return _errorView(context, state.msg);
            }

            if (state is ProfileUpdateServerFailureState) {
              return _errorView(context, state.msg);
            }

            // ProfileInitial and ProfileUpdateSuccessState both show the form
            return _bodyView(context);
          },
        ),
      ),
    );
  }

  /// Displays an error message with a retry button.
  Widget _errorView(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<ProfileBloc>().add(GetProfileEvent());
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfilePersonalInfo(
                  firstNameController: firstName,
                  lastNameController: lastName,
                  emailController: email,
                  genderNotifier: genderNotifier,
                  isEditMode: isEditMode,
                ),
                const SizedBox(height: 30),
                ProfileAddressInfo(
                  addressController: address,
                  landmarkController: landmark,
                  pincodeController: pincode,
                  isEditMode: isEditMode,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ProfileActionButtons(
              isEditMode: isEditMode,
              onEditPressed: () {
                setState(() {
                  isEditMode = true;
                });
              },
              onUpdatePressed: () {
                if (genderNotifier.value == null) {
                  SnackbarService.error("Please select a gender");
                  return;
                }
                if (_formKey.currentState!.validate()) {
                  context.read<ProfileBloc>().add(
                    ProfileUpdateRequestedEvent(
                      entity: ProfileEntity(
                        name: "${firstName.text} ${lastName.text}",
                        email: email.text,
                        gender: genderNotifier.value!.toLowerCase(),
                        fullAddress: address.text,
                        landmark: landmark.text,
                        pincode: pincode.text,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
