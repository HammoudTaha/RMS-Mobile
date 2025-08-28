part of 'pass_data_bloc.dart';

class PassDataState extends Equatable {
  final OrderType? orderType;
  final DeliveryInfo? deliveryInfo;
  final PaymentMethod? paymentMethod;
  final String? reservationId;
  const PassDataState({
    this.orderType,
    this.paymentMethod,
    this.deliveryInfo,
    this.reservationId,
  });

  PassDataState copyWith({
    OrderType? orderType,
    DeliveryInfo? deliveryInfo,
    PaymentMethod? paymentMethod,
    String? reservationId,
  }) {
    return PassDataState(
      orderType: orderType ?? this.orderType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryInfo: deliveryInfo ?? this.deliveryInfo,
      reservationId: reservationId ?? this.reservationId,
    );
  }

  @override
  List<Object?> get props => [
    orderType,
    paymentMethod,
    deliveryInfo,
    reservationId,
  ];
}
