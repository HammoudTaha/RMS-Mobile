part of 'category_bloc.dart';

sealed class CategoryEvent {
  const CategoryEvent();
}

class FetchCategoriesEvent extends CategoryEvent {
  const FetchCategoriesEvent();
}
