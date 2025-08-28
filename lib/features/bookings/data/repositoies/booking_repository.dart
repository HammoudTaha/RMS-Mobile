import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/connection_info.dart';
import '../data_source/remote/remote_booking_data_source.dart';
import '../models/booking/booking.dart';

class BookingRepository {
  final RemoteBookingDataSource _remoteBooingDataSource;
  final ConnectionInfo _connectionInfo;
  BookingRepository(this._remoteBooingDataSource, this._connectionInfo);
  Future<Either<Failure, List<Booking>>> bookings() async {
    if (await _connectionInfo.checkConnection()) {
      final remoteResponse = await _remoteBooingDataSource.bookings();
      return remoteResponse.fold((l) => Left(l), (r) {
        try {
          final List<Booking> bookings =
              (r as List).map((e) => Booking.fromJson(e)).toList();
          return Right(bookings);
        } on Exception catch (_) {
          return Left(
            Failure(message: 'Something went wrong, Please try again'),
          );
        }
      });
    } else {
      return Left(Failure(message: 'No internet Connection, Please try again'));
    }
  }
}
