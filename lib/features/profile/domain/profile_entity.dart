import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String name;
  final String email;
  final String gender;
  final String fullAddress;
  final String landmark;
  final String pincode;

  const ProfileEntity({
    required this.name,
    required this.email,
    required this.gender,
    required this.fullAddress,
    required this.landmark,
    required this.pincode,
  });

  @override
  List<Object?> get props => [name, email, gender, fullAddress, landmark, pincode];
}
