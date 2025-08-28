part of 'favorite_bloc.dart';

sealed class FavoriteEvent {
  const FavoriteEvent();
}

class FetchFavoriteEvent extends FavoriteEvent {
  const FetchFavoriteEvent();
}

class AddFavoriteEvent extends FavoriteEvent {
  final Restaurant restaurant;
  const AddFavoriteEvent(this.restaurant);
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final int id;
  const RemoveFavoriteEvent(this.id);
}

class IsFavoriteEvent extends FavoriteEvent {
  final int id;
  const IsFavoriteEvent(this.id);
}
