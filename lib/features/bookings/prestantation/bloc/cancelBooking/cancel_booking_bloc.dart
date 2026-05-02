import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/repositoies/booking_repository.dart';
part 'cancel_booking_state.dart';
part 'cancel_booking_event.dart';

class CancelBookingBloc extends Bloc<CancelBookEvent, CancelBookingState> {
  CancelBookingBloc() : super(InitialCancelBookingState()) {
    on<CancelBookEvent>(_onCancelBookingEvent);
  }

  void _onCancelBookingEvent(
    CancelBookEvent event,
    Emitter<CancelBookingState> emit,
  ) async {
    emit(LoadingCancelBookingState());
    final result = await (await getIt<Future<BookingRepository>>()).cancelBook(
      event.bookId,
    );
    result.fold(
      (fail) => emit(FailedCancelBookingState(fail.message)),
      (message) => emit(CanceledBookingState(message)),
    );
  }
}
