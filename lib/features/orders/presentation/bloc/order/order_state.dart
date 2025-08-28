part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();
  @override
  List<Object> get props => [];
}

class InitialOrderState extends OrderState {
  const InitialOrderState();
  @override
  List<Object> get props => [];
}

class LoadingOrdeerState extends OrderState {
  const LoadingOrdeerState();
  @override
  List<Object> get props => [];
}

class FailedOrderState extends OrderState {
  final String message;
  const FailedOrderState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedOrdersState extends OrderState {
  final List<Order> orders;
  const FetchedOrdersState(this.orders);
  @override
  List<Object> get props => [orders];
}

class FetchedOrderDetailsState extends OrderState {
  final OrderDetails order;
  const FetchedOrderDetailsState(this.order);
  @override
  List<Object> get props => [order];
}

class CreatedOrderState extends OrderState {
  final Map<String, dynamic> data;
  const CreatedOrderState(this.data);
  @override
  List<Object> get props => [data];
}
