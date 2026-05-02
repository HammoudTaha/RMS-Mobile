import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../auth/data/data_source/remote/user_remote_data_source.dart';
import '../../../restaurant/data/models/restaurant/restaurant.dart';
import '../data_source/local/favorite_local_data_source.dart';

class FavoriteRepository {
  final FavoriteLocalDataSource _favoriteLocalDataSource;
  FavoriteRepository(this._favoriteLocalDataSource);

  Either<Failure, List<Restaurant>> fetchFavorite() {
    final favorites = _favoriteLocalDataSource.fetchFavorite();
    return favorites.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, NoParams> addFavorite(Restaurant restaurant) {
    final favorites = _favoriteLocalDataSource.addFavorite(restaurant);
    return favorites.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, NoParams> removeFavorite(String restaurantId) {
    final favorites = _favoriteLocalDataSource.removeFavorite(restaurantId);
    return favorites.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, bool> isFavorite(String restaurantId) {
    final isfavorite = _favoriteLocalDataSource.isFavorite(restaurantId);
    return isfavorite.fold((l) => Left(l), (r) => Right(r));
  }
}
