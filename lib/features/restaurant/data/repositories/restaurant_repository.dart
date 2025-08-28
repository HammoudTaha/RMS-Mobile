import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/connection_info.dart';
import '../data_source/remote/restaurant_remote_data_source.dart';
import '../models/menu/menu.dart';
import '../models/restaurant/restaurant.dart';

class RestaurantRepository {
  final RestaurantRemoteDataSource _restaurantRemoteDataSource;
  final ConnectionInfo _connectionInfo;

  RestaurantRepository(this._restaurantRemoteDataSource, this._connectionInfo);

  Future<Either<Failure, Restaurant>> restaurant(String id) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _restaurantRemoteDataSource.restaurant(id);
      return remoteResponse.fold((l) => Left(l), (r) {
        return Right(Restaurant.formJson(r));
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, List<Menu>>> menu(int id) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _restaurantRemoteDataSource.menu(id);
      return remoteResponse.fold((l) => Left(l), (r) {
        final List<Menu> menu =
            r.map((element) {
              element['restaurant_id'] = id;
              return Menu.formJson(element);
            }).toList();
        return Right(menu);
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }
}
