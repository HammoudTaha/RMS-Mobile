part of 'order_bloc.dart';

sealed class OrderEvent {
  const OrderEvent();
}

class FetchOrdersEvent extends OrderEvent {
  const FetchOrdersEvent();
}

class FetchOrdersDetailsEvent extends OrderEvent {
  final String id;
  const FetchOrdersDetailsEvent(this.id);
}

class CreateOrderEvent extends OrderEvent {
  final OrderParams params;
  const CreateOrderEvent(this.params);
}
