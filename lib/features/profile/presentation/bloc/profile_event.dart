part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {}

final class ProfileUpdateRequestedEvent extends ProfileEvent {
  final ProfileEntity entity;

  ProfileUpdateRequestedEvent({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class MakeProfileEditViewEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class EnableProfileEditEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
