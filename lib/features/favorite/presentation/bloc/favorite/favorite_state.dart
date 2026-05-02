part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();
  @override
  List<Object> get props => [];
}

class InitialFavoriteState extends FavoriteState {
  const InitialFavoriteState();
  @override
  List<Object> get props => [];
}

class LoadingFavoriteState extends FavoriteState {
  const LoadingFavoriteState();
  @override
  List<Object> get props => [];
}

class FailedFavoriteState extends FavoriteState {
  final String message;
  const FailedFavoriteState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedFavoriteState extends FavoriteState {
  final List<Restaurant> restaurant;
  const FetchedFavoriteState(this.restaurant);
  @override
  List<Object> get props => [restaurant];
}

// class AddedFavoriteState extends FavoriteState {
//   const AddedFavoriteState();
//   @override
//   List<Object> get props => [];
// }

// class RemoverdFavoriteState extends FavoriteState {
//   const RemoverdFavoriteState();
//   @override
//   List<Object> get props => [];
// }

class FavoritedState extends FavoriteState {
  final bool isFavorited;
  const FavoritedState(this.isFavorited);
  @override
  List<Object> get props => [];
}
