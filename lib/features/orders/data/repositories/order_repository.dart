import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/connection_info.dart';
import '../data_source/remote/order_remote_data_source.dart';
import '../models/order/order.dart' as order;
import '../models/order_details/order_details.dart';

class OrderRepository {
  final OrderRemoteDataSource _orderRemoteDataSource;
  final ConnectionInfo _connectionInfo;

  const OrderRepository(this._orderRemoteDataSource, this._connectionInfo);

  Future<Either<Failure, List<order.Order>>> orders() async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _orderRemoteDataSource.orders();
      return remoteResponse.fold((l) => left(l), (r) {
        try {
          final List<order.Order> orders = [];
          for (var element in r) {
            orders.add(order.Order.fromJson(element));
          }
          return Right(orders);
        } on Exception catch (_) {
          return left(
            Failure(message: 'Somthing went wrong, Please try again'),
          );
        }
      });
    } else {
      return left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, OrderDetails>> orderDetails(String id) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _orderRemoteDataSource.orderDetails(id);
      return remoteResponse.fold((l) => left(l), (r) {
        try {
          final order = OrderDetails.fromJson(r);
          return Right(order);
        } on Exception catch (_) {
          return left(
            Failure(message: 'Somthing went wrong, Please try again'),
          );
        }
      });
    } else {
      return left(Failure(message: 'No internet Connection, Please try again'));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> createOrder(
    OrderParams params,
  ) async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _orderRemoteDataSource.createOrder(params);
      return remoteResponse.fold((l) => left(l), (r) => right(r));
    } else {
      return left(Failure(message: 'No internet Connection, Please try again'));
    }
  }
}
