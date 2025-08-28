part of 'restaurant_bloc.dart';

sealed class RestaurantState extends Equatable {
  const RestaurantState();
  @override
  List<Object> get props => [];
}

class InitialRestaurantState extends RestaurantState {
  const InitialRestaurantState();
  @override
  List<Object> get props => [];
}

class LoadingRestaurantState extends RestaurantState {
  const LoadingRestaurantState();
  @override
  List<Object> get props => [];
}

class FailedRestaurantState extends RestaurantState {
  final String message;
  const FailedRestaurantState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedRestaurantState extends RestaurantState {
  final Restaurant restaurant;
  const FetchedRestaurantState(this.restaurant);
  @override
  List<Object> get props => [restaurant];
}
