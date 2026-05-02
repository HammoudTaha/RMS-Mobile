part of 'pass_data_bloc.dart';

class PassDataState extends Equatable {
  final OrderType orderType;
  final DeliveryInfo? deliveryInfo;
  final PaymentMethod? paymentMethod;
  final Booking? booking;
  final String? restaurantId;
  const PassDataState({
    this.orderType = OrderType.delivery,
    this.paymentMethod,
    this.deliveryInfo,
    this.booking,
    this.restaurantId,
  });

  PassDataState copyWith({
    OrderType? orderType,
    DeliveryInfo? deliveryInfo,
    PaymentMethod? paymentMethod,
    Booking? booking,
    String? restaurantId,
  }) {
    return PassDataState(
      orderType: orderType ?? this.orderType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryInfo: deliveryInfo ?? this.deliveryInfo,
      booking: booking ?? this.booking,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  @override
  List<Object?> get props => [
    orderType,
    paymentMethod,
    deliveryInfo,
    booking,
    restaurantId,
  ];
}
