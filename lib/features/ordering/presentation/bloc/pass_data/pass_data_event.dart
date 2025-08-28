part of 'pass_data_bloc.dart';

class PassDataEvent {
  final OrderType? orderType;
  final DeliveryInfo? deliveryInfo;
  final PaymentMethod? paymentMethod;
  final String? reservationId;
  const PassDataEvent({
    this.orderType,
    this.paymentMethod,
    this.deliveryInfo,
    this.reservationId,
  });
}
