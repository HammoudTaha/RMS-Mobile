import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_managment_mobile/features/orders/data/models/order_details/order_details.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/data_source/remote/order_remote_data_source.dart';
import '../../../data/models/order/order.dart';
import '../../../data/repositories/order_repository.dart';
part 'order_state.dart';
part 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(InitialOrderState()) {
    on<FetchOrdersEvent>(_onFetchOrdersEvent);
    on<CreateOrderEvent>(_onCreateOrderEvent);
    on<FetchOrdersDetailsEvent>(_onFetchOrdersDetailsEvent);
  }

  void _onFetchOrdersEvent(
    FetchOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(LoadingOrdeerState());
    final result = await (await getIt<Future<OrderRepository>>()).orders();
    result.fold(
      (fail) => emit(FailedOrderState(fail.message)),
      (orders) => emit(FetchedOrdersState(orders)),
    );
  }

  void _onFetchOrdersDetailsEvent(
    FetchOrdersDetailsEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(LoadingOrdeerState());
    final result = await (await getIt<Future<OrderRepository>>()).orderDetails(
      event.id,
    );
    result.fold(
      (fail) => emit(FailedOrderState(fail.message)),
      (order) => emit(FetchedOrderDetailsState(order)),
    );
  }

  void _onCreateOrderEvent(
    CreateOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(LoadingOrdeerState());
    final result = await (await getIt<Future<OrderRepository>>()).createOrder(
      event.params,
    );
    result.fold(
      (fail) => emit(FailedOrderState(fail.message)),
      (data) => emit(CreatedOrderState(data)),
    );
  }
}
