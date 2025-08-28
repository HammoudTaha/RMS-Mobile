part of 'delivery_address_bloc.dart';

class DeliveryAddressEvent {
  const DeliveryAddressEvent();
}

class FetchDeliveryAddressesEvent extends DeliveryAddressEvent {
  const FetchDeliveryAddressesEvent();
}

class FetchDeliveryAddressEvent extends DeliveryAddressEvent {
  final String deliveryAddressId;
  const FetchDeliveryAddressEvent(this.deliveryAddressId);
}

class AddDeliveryAddressEvent extends DeliveryAddressEvent {
  final DeliveryInfo deliveryAddress;
  const AddDeliveryAddressEvent(this.deliveryAddress);
}

class DeleteDeliveryAddressEvent extends DeliveryAddressEvent {
  final String deliveryAddressId;

  const DeleteDeliveryAddressEvent(this.deliveryAddressId);
}

class EditDeliveryAddressEvent extends DeliveryAddressEvent {
  final DeliveryInfo deliveryAddress;
  final String deliveryAddressId;
  const EditDeliveryAddressEvent(this.deliveryAddress, this.deliveryAddressId);
}
