part of 'pass_data_bloc.dart';

class PassDataEvent {
  final OrderType? orderType;
  final DeliveryInfo? deliveryInfo;
  final PaymentMethod? paymentMethod;
  final Booking? booking;
  final String? restaurantId;
  const PassDataEvent({
    this.orderType,
    this.paymentMethod,
    this.deliveryInfo,
    this.booking,
    this.restaurantId,
  });
}
