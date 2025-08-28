import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/api-service/api_service.dart';
import '../../../../../core/utils/enum.dart';

class OrderRemoteDataSource {
  final ApiService _apiService;

  const OrderRemoteDataSource(this._apiService);

  Future<Either<Failure, List>> orders() async {
    try {
      final data = await _apiService.get(endpoint: AppStrings.orders);
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, dynamic>> orderDetails(String id) async {
    try {
      final data = await _apiService.get(endpoint: '${AppStrings.orders}/$id');
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> createOrder(
    OrderParams params,
  ) async {
    try {
      final data = await _apiService.post(
        endpoint: AppStrings.createOrder,
        data: {
          'restaurant_id': params.restaurantId,
          'order_type':
              params.orderType == OrderType.dineIn
                  ? 'dine-in'
                  : params.orderType == OrderType.delivery
                  ? 'delivery'
                  : 'pickup',
          'reservation_id': params.reservationId,
          'delivery_address': params.deliveryAddress,
          'payment_method': 'cash',
          'special_instructions': 'no thing',
          'items': params.items,
        },
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}

class OrderParams {
  final String restaurantId;
  final OrderType orderType;
  final PaymentMethod paymentMethod;
  final String? deliveryAddress;
  final String? reservationId;
  final List<Map<String, dynamic>> items;

  OrderParams({
    required this.restaurantId,
    required this.orderType,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.reservationId,
    required this.items,
  });
}
