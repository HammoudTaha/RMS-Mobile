part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchState {
  const InitialSearchState();
  @override
  List<Object> get props => [];
}

class LoadingSearchState extends SearchState {
  const LoadingSearchState();
  @override
  List<Object> get props => [];
}

class FailedSearchState extends SearchState {
  final String message;
  const FailedSearchState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedRestaurantsSearchState extends SearchState {
  final List<Restaurant> restaurants;
  const FetchedRestaurantsSearchState(this.restaurants);
  @override
  List<Object> get props => [restaurants];
}
