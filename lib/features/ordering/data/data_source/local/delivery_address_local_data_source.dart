import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/local_service/local_storage.dart';
import '../../models/delivery_address/delivery_info.dart';

class DeliveryAddressLocalDataSource {
  final LocalStorage<DeliveryInfo> _deliveryAddressLocalStorage;

  DeliveryAddressLocalDataSource(this._deliveryAddressLocalStorage);
  Either<Failure, List<DeliveryInfo>> fetchDeliveryAddresses() {
    try {
      List<DeliveryInfo> deliveryAddresses = _deliveryAddressLocalStorage.get();
      return Right(deliveryAddresses);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, DeliveryInfo> fetchDeliveryAddress(String id) {
    try {
      DeliveryInfo deliveryAddress = _deliveryAddressLocalStorage
          .get()
          .firstWhere((element) => element.id == id);
      return Right(deliveryAddress);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, List<DeliveryInfo>> addDeliveryAddress(
    DeliveryInfo deliveryAddress,
  ) {
    try {
      _deliveryAddressLocalStorage.store(deliveryAddress);
      List<DeliveryInfo> deliveryAddresses = _deliveryAddressLocalStorage.get();
      return Right(deliveryAddresses);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, List<DeliveryInfo>> deleteDeliveryAddress(
    String deliveryAddressId,
  ) {
    try {
      List<DeliveryInfo> deliveryAddresses = _deliveryAddressLocalStorage.get();
      int index = deliveryAddresses.indexWhere(
        (element) => element.id == deliveryAddressId,
      );
      _deliveryAddressLocalStorage.delete(index);
      deliveryAddresses.removeAt(index);
      return Right(deliveryAddresses);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, List<DeliveryInfo>> editDeliveryAddress(
    String deliverAddressId,
    DeliveryInfo deliverAddress,
  ) {
    try {
      List<DeliveryInfo> deliveryAddresses = _deliveryAddressLocalStorage.get();
      int index = deliveryAddresses.indexWhere(
        (element) => element.id == deliverAddressId,
      );

      for (var element in deliveryAddresses) {
        deleteDeliveryAddress(element.id);
      }
      deliveryAddresses[index] = deliverAddress;
      for (var element in deliveryAddresses) {
        addDeliveryAddress(element);
      }
      return Right(deliveryAddresses);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }
}
