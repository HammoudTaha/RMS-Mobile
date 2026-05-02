part of 'restaurant_bloc.dart';

sealed class RestaurantEvent {
  const RestaurantEvent();
}

class FetchRestaurantsEvent extends RestaurantEvent {
  final String categoryId;
  const FetchRestaurantsEvent(this.categoryId);
}
