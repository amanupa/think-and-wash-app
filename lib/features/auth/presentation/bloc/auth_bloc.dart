import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/auth/domain/get_otp_usecase.dart';
import 'package:think_and_wash/features/auth/domain/submit_otp_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetOtpUsecase getOtpUsecase;
  final SubmitOtpUsecase submitOtpUsecase;

  AuthBloc({required this.getOtpUsecase, required this.submitOtpUsecase})
    : super(AuthInitial()) {
    on<OtpRequested>(_otpRequested);
    on<OtpValidationRequested>(_otpValidation);
  }

  FutureOr<void> _otpRequested(
    OtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(OtpRequestedLoading());
    try {
      if (event.phn == "9999999999") {
        emit(OtpRequestedSuccess(otp: "1234"));
      } else {
        print("this is the phn for otp request: ${event.phn}");
        final result = await getOtpUsecase(event.phn);
        result.fold(
          (failure) {
            emit(OtpRequestedFailure(msg: failure.message ?? "otp failure"));
          },
          (success) {
            emit(OtpRequestedSuccess(otp: success));
          },
        );
      }
    } catch (err) {
      emit(OtpRequestedFailure(msg: "server error"));
    }
  }

  FutureOr<void> _otpValidation(
    OtpValidationRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(OtpValidationLoading());
    if (event.otp == "1234") {
      emit(OtpValidationSuccess(usrId: "Demo"));
    } else {
      emit(OtpValidationFailure());
    }
  }
}
