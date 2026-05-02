part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}

class FetchRestaurantsSearchEvent extends SearchEvent {
  final String name;
  const FetchRestaurantsSearchEvent(this.name);
}
