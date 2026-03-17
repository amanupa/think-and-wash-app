import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_and_wash/features/categories/domain/usecase/get_categories_usecase.dart';
import 'package:think_and_wash/features/categories/presentation/bloc/categories_event.dart';
import 'package:think_and_wash/features/categories/presentation/bloc/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesBloc({required this.getCategoriesUseCase})
    : super(CategoriesInitial()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
  }

  Future<void> _onFetchCategories(
    FetchCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    final result = await getCategoriesUseCase(event.vendorId);

    result.fold(
      (failure) => emit(
        CategoriesError(
          message: failure.message ?? "Failed to fetch categories",
        ),
      ),
      (categories) => emit(CategoriesLoaded(categoryModel: categories)),
    );
  }
}
