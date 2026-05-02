import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/local_service/local_storage.dart';
import '../../../../auth/data/data_source/remote/user_remote_data_source.dart';
import '../../../../restaurant/data/models/restaurant/restaurant.dart';

class FavoriteLocalDataSource {
  final LocalStorage<Restaurant> _favoriteLocalStorage;
  FavoriteLocalDataSource(this._favoriteLocalStorage);

  Either<Failure, List<Restaurant>> fetchFavorite() {
    try {
      List<Restaurant> restaurants = _favoriteLocalStorage.get();
      return Right(restaurants);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, NoParams> addFavorite(Restaurant restaurant) {
    try {
      _favoriteLocalStorage.store(restaurant);
      return Right(NoParams());
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, NoParams> removeFavorite(String restaurantId) {
    try {
      List<Restaurant> restaurants = _favoriteLocalStorage.get();
      int index = restaurants.indexWhere(
        (element) => element.id == restaurantId,
      );
      _favoriteLocalStorage.delete(index);
      return Right(NoParams());
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, bool> isFavorite(String restaurantId) {
    try {
      List<Restaurant> restaurants = _favoriteLocalStorage.get();
      final isFavorite =
          restaurants.where((element) => element.id == restaurantId).isNotEmpty;
      return Right(isFavorite);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }
}
