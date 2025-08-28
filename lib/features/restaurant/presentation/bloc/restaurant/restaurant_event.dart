part of 'restaurant_bloc.dart';

sealed class RestaurantEvent {
  const RestaurantEvent();
}

class FetchRestaurantEvent extends RestaurantEvent {
  final String id;
  const FetchRestaurantEvent(this.id);
}
