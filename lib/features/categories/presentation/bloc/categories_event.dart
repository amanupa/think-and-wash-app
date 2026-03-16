import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class FetchCategoriesEvent extends CategoriesEvent {
  final String vendorId;

  const FetchCategoriesEvent({required this.vendorId});

  @override
  List<Object?> get props => [vendorId];
}
