part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object> get props => [];
}

class InitialCategoryState extends CategoryState {
  const InitialCategoryState();
  @override
  List<Object> get props => [];
}

class LoadingCategoryState extends CategoryState {
  const LoadingCategoryState();
  @override
  List<Object> get props => [];
}

class FailedCategoryState extends CategoryState {
  final String message;
  const FailedCategoryState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedCategoriesState extends CategoryState {
  final List<Category> categories;
  const FetchedCategoriesState(this.categories);
  @override
  List<Object> get props => [categories];
}
