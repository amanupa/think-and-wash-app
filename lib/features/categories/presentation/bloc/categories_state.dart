import 'package:equatable/equatable.dart';
import 'package:think_and_wash/features/categories/data/model/category_model.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final CategoryItemModel categoryModel;

  const CategoriesLoaded({required this.categoryModel});

  @override
  List<Object?> get props => [categoryModel];
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError({required this.message});

  @override
  List<Object?> get props => [message];
}
