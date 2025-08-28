import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/connection_info.dart';
import '../data_source/remote/home_remote_data_source.dart';
import '../models/category/category.dart';
import '../../data/models/restaurant/restaurant.dart';

class HomeRepository {
  final HomeRemoteDataSource _restaurantRemoteDataSource;
  final ConnectionInfo _connectionInfo;

  HomeRepository(this._restaurantRemoteDataSource, this._connectionInfo);

  Future<Either<Failure, List<Category>>> categories() async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _restaurantRemoteDataSource.categories();
      return remoteResponse.fold((l) => Left(l), (r) {
        List<Category> categories =
            r.map((element) => Category.fromJson(element)).toList();
        return Right(categories);
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, List<Restaurant>>> restaurants(
    String categoryId,
  ) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _restaurantRemoteDataSource.restaurants(
        categoryId,
      );
      return remoteResponse.fold((l) => Left(l), (r) {
        List<Restaurant> restaurant =
            r.map((element) => Restaurant.formJson(element)).toList();
        return Right(restaurant);
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, List<Restaurant>>> restaurantsByName(
    String name,
  ) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _restaurantRemoteDataSource
          .restaurantsByName(name);
      return remoteResponse.fold((l) => Left(l), (r) {
        List<Restaurant> restaurant =
            r.map((element) => Restaurant.formJson(element)).toList();
        return Right(restaurant);
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }
}
