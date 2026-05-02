import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/di/service_locator.dart';
import '../../../data/models/category/category.dart';
import '../../../data/repositories/home_repository.dart';

part 'category_state.dart';
part 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(InitialCategoryState()) {
    on<FetchCategoriesEvent>(_onFetchCategoriesEvent);
  }

  void _onFetchCategoriesEvent(
    FetchCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(LoadingCategoryState());
    final result = await (await getIt<Future<HomeRepository>>()).categories();
    result.fold(
      (fail) => emit(FailedCategoryState(fail.message)),
      (categories) => emit(FetchedCategoriesState(categories)),
    );
  }
}
