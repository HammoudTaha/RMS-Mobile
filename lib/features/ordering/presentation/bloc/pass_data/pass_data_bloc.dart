import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/enum.dart';
import '../../../data/models/delivery_address/delivery_info.dart';
part 'pass_data_state.dart';
part 'pass_data_event.dart';

class PassDataBloc extends Bloc<PassDataEvent, PassDataState> {
  PassDataBloc() : super(PassDataState()) {
    on<PassDataEvent>((event, emit) {
      emit(
        state.copyWith(
          orderType: event.orderType,
          paymentMethod: event.paymentMethod,
          deliveryInfo: event.deliveryInfo,
          reservationId: event.reservationId,
        ),
      );
    });
  }
}
