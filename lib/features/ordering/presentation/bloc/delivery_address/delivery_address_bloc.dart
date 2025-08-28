import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/models/delivery_address/delivery_info.dart';
import '../../../data/repositories/delivery_address_repository.dart';
part 'delivery_address_state.dart';
part 'delivery_address_event.dart';

class DeliveryAddressBloc
    extends Bloc<DeliveryAddressEvent, DeliveryAddressState> {
  DeliveryAddressBloc() : super(InitialDeliveryAddressState()) {
    on<AddDeliveryAddressEvent>(_onAddDeliveryAddressEvent);
    on<EditDeliveryAddressEvent>(_onEditDeliveryAddressEvent);
    on<FetchDeliveryAddressEvent>(_onFetchDeliveryAddressEvent);
    on<DeleteDeliveryAddressEvent>(_onDeleteDeliveryAddressEvent);
    on<FetchDeliveryAddressesEvent>(_onFetchDeliveryAddressesEvent);
  }

  void _onFetchDeliveryAddressesEvent(
    FetchDeliveryAddressesEvent event,
    Emitter<DeliveryAddressState> emit,
  ) async {
    emit(LoadingDeliveryAddressState());
    final result =
        (await getIt<Future<DeliveryAddressRepository>>())
            .fetchDeliveryAddresses();
    result.fold(
      (fail) => emit(FailedDeliveryAddressState(fail.message)),
      (deliveryAddresses) =>
          emit(FetchedDeliveryAddressesState(deliveryAddresses)),
    );
  }

  void _onFetchDeliveryAddressEvent(
    FetchDeliveryAddressEvent event,
    Emitter<DeliveryAddressState> emit,
  ) async {
    emit(LoadingDeliveryAddressState());
    final result = (await getIt<Future<DeliveryAddressRepository>>())
        .fetchDeliveryAddress(event.deliveryAddressId);
    result.fold(
      (fail) => emit(FailedDeliveryAddressState(fail.message)),
      (deliveryAddress) => emit(FetchedDeliveryAddressState(deliveryAddress)),
    );
  }

  void _onAddDeliveryAddressEvent(
    AddDeliveryAddressEvent event,
    Emitter<DeliveryAddressState> emit,
  ) async {
    emit(LoadingDeliveryAddressState());
    final result = (await getIt<Future<DeliveryAddressRepository>>())
        .addDeliveryAddress(event.deliveryAddress);
    result.fold(
      (fail) => emit(FailedDeliveryAddressState(fail.message)),
      (deliveryAddresses) =>
          emit(FetchedDeliveryAddressesState(deliveryAddresses)),
    );
  }

  void _onDeleteDeliveryAddressEvent(
    DeleteDeliveryAddressEvent event,
    Emitter<DeliveryAddressState> emit,
  ) async {
    emit(LoadingDeliveryAddressState());
    final result = (await getIt<Future<DeliveryAddressRepository>>())
        .deleteDeliveryAddress(event.deliveryAddressId);
    result.fold(
      (fail) => emit(FailedDeliveryAddressState(fail.message)),
      (deliveryAddresses) =>
          emit(FetchedDeliveryAddressesState(deliveryAddresses)),
    );
  }

  void _onEditDeliveryAddressEvent(
    EditDeliveryAddressEvent event,
    Emitter<DeliveryAddressState> emit,
  ) async {
    emit(LoadingDeliveryAddressState());
    final result = (await getIt<Future<DeliveryAddressRepository>>())
        .editDeliveryAddress(event.deliveryAddressId, event.deliveryAddress);
    result.fold(
      (fail) => emit(FailedDeliveryAddressState(fail.message)),
      (deliveryAddresses) =>
          emit(FetchedDeliveryAddressesState(deliveryAddresses)),
    );
  }
}
