part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileLoadingStat extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileUpdateSuccessState extends ProfileState {
  final User usr;

  ProfileUpdateSuccessState({required this.usr});
  @override
  List<Object?> get props => [usr];
}

final class ProfileUpdateFailureState extends ProfileState {
  final String msg;

  ProfileUpdateFailureState({required this.msg});
  @override
  List<Object?> get props => [msg];
}

final class ProfileUpdateServerFailureState extends ProfileState {
  final String msg;

  ProfileUpdateServerFailureState({required this.msg});
  @override
  List<Object?> get props => [msg];
}
