part of 'top_restaurant_bloc.dart';

sealed class TopRestarantState extends Equatable {
  const TopRestarantState();
  @override
  List<Object> get props => [];
}

class InitialTopRestarantState extends TopRestarantState {
  const InitialTopRestarantState();
  @override
  List<Object> get props => [];
}

class LoadingTopRestarantState extends TopRestarantState {
  const LoadingTopRestarantState();
  @override
  List<Object> get props => [];
}

class FailedTopRestarantState extends TopRestarantState {
  final String message;
  const FailedTopRestarantState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedTopRestarantsState extends TopRestarantState {
  final List<Restaurant> restaurants;
  const FetchedTopRestarantsState(this.restaurants);
  @override
  List<Object> get props => [restaurants];
}
