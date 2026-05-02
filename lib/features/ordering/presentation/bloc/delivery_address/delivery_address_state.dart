part of 'delivery_address_bloc.dart';

sealed class DeliveryAddressState extends Equatable {
  const DeliveryAddressState();
  @override
  List<Object> get props => [];
}

class InitialDeliveryAddressState extends DeliveryAddressState {
  const InitialDeliveryAddressState();
  @override
  List<Object> get props => [];
}

class LoadingDeliveryAddressState extends DeliveryAddressState {
  const LoadingDeliveryAddressState();
  @override
  List<Object> get props => [];
}

class FailedDeliveryAddressState extends DeliveryAddressState {
  final String message;
  const FailedDeliveryAddressState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedDeliveryAddressesState extends DeliveryAddressState {
  final List<DeliveryInfo> deliveryAddresses;
  const FetchedDeliveryAddressesState(this.deliveryAddresses);
  @override
  List<Object> get props => [deliveryAddresses];
}

class FetchedDeliveryAddressState extends DeliveryAddressState {
  final DeliveryInfo deliveryAddress;
  const FetchedDeliveryAddressState(this.deliveryAddress);
  @override
  List<Object> get props => [deliveryAddress];
}
