import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/snack_bar_messages.dart';
import 'package:think_and_wash/features/auth/domain/auth_entity.dart';
import 'package:think_and_wash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:think_and_wash/route/app_routes.dart';

import '../widgets/otp_form.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController phnController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpRequestedFailure) {
            SnackbarService.error(state.msg);
          }
          if (state is OtpValidationFailure) {
            SnackbarService.error(state.msg);
          }
          if (state is OtpValidationSuccess || state is StaticOtpValidationSuccess) {
            Navigator.of(context).pushNamed(AppRoutes.home);
          }
        },
        builder: (context, state) {
          if (state is OtpRequestedSuccess ||
              state is OtpValidationFailure ||
              state is OtpValidationLoading ||
              state is StaticOtpValidationSuccess) {
            return OtpTextFieldForm(
              formController: otpController,
              page: "Submit Otp",
              hintText: "Enter Otp",
              buttonText: "Submit Otp",
              isLoading: state is OtpValidationLoading,
              onPressed: () {
                context.read<AuthBloc>().add(
                  OtpValidationRequested(
                    entity: AuthEntity(
                      otp: otpController.text,
                      phone:
                          state is OtpRequestedSuccess
                              ? state.phn
                              : state is OtpValidationFailure
                              ? state.phn
                              : state is OtpValidationLoading
                              ? "" // Not reachable since button is disabled
                              : "",
                      role: "customer",
                    ),
                  ),
                );
                otpController.text = "";
              },
            );
          }
          if (state is OtpRequestedFailure ||
              state is AuthInitial ||
              state is OtpRequestedLoading) {
            return OtpTextFieldForm(
              formController: phnController,
              page: "Otp",
              hintText: "Phone number for otp",
              buttonText: "Otp",
              isLoading: state is OtpRequestedLoading,
              onPressed: () {
                context.read<AuthBloc>().add(
                  OtpRequested(phn: phnController.text),
                );
                phnController.text = "";
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
