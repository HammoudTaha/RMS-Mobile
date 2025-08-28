import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../data_source/local/delivery_address_local_data_source.dart';
import '../models/delivery_address/delivery_info.dart';

class DeliveryAddressRepository {
  final DeliveryAddressLocalDataSource _deliveryAddressLocalDataSource;

  DeliveryAddressRepository(this._deliveryAddressLocalDataSource);
  Either<Failure, List<DeliveryInfo>> fetchDeliveryAddresses() {
    final deliveryAddresses =
        _deliveryAddressLocalDataSource.fetchDeliveryAddresses();
    return deliveryAddresses.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, DeliveryInfo> fetchDeliveryAddress(String id) {
    final deliveryAddress = _deliveryAddressLocalDataSource
        .fetchDeliveryAddress(id);
    return deliveryAddress.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<DeliveryInfo>> addDeliveryAddress(
    DeliveryInfo deliveryAddress,
  ) {
    final deliveryAddresses = _deliveryAddressLocalDataSource
        .addDeliveryAddress(deliveryAddress);
    return deliveryAddresses.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<DeliveryInfo>> deleteDeliveryAddress(
    String deliveryAddressId,
  ) {
    final deliveryAddresses = _deliveryAddressLocalDataSource
        .deleteDeliveryAddress(deliveryAddressId);
    return deliveryAddresses.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<DeliveryInfo>> editDeliveryAddress(
    String deliveryAddressId,
    DeliveryInfo deliverAddress,
  ) {
    final deliveryAddresses = _deliveryAddressLocalDataSource
        .editDeliveryAddress(deliveryAddressId, deliverAddress);
    return deliveryAddresses.fold((l) => Left(l), (r) => Right(r));
  }
}
