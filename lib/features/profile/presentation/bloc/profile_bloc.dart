import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/core/usecase_interfase.dart';
import 'package:think_and_wash/features/profile/domain/get_profile_usecase.dart';
import 'package:think_and_wash/features/profile/domain/profile_entity.dart';
import 'package:think_and_wash/features/profile/domain/profile_usecase.dart';

import '../../../auth/data/auth_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecase profileUsecase;
  final GetProfileUsecase getProfileUsecase;
  ProfileBloc({required this.profileUsecase, required this.getProfileUsecase})
    : super(ProfileInitial()) {
    on<ProfileUpdateRequestedEvent>(_updateProfile);
    on<GetProfileEvent>(_getProfile);
  }

  FutureOr<void> _updateProfile(
    ProfileUpdateRequestedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingStat());
    try {
      debugPrint(
        "this is the entity data to update profile: ${event.entity.email},${event.entity.name},${event.entity.gender},${event.entity.fullAddress},${event.entity.landmark},${event.entity.pincode}",
      );
      final result = await profileUsecase(event.entity);
      result.fold(
        (failure) {
          emit(
            ProfileUpdateFailureState(
              msg: failure.message ?? "Failled to update profile",
            ),
          );
        },
        (success) {
          emit(ProfileUpdateSuccessState(usr: success));
        },
      );
    } catch (err) {
      emit(ProfileUpdateServerFailureState(msg: "Server failure "));
    }
  }

  FutureOr<void> _getProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingStat());
    try {
      final result = await getProfileUsecase(NoParams());
      debugPrint("get profile result: $result");
      result.fold(
        (failure) {
          emit(
            ProfileUpdateFailureState(
              msg: failure.message ?? "Unable to get the profile",
            ),
          );
        },
        (success) {
          emit(ProfileUpdateSuccessState(usr: success));
        },
      );
    } catch (err) {
      debugPrint("get profile catch block");
      emit(ProfileUpdateServerFailureState(msg: "Its not you its us"));
    }
  }
}
