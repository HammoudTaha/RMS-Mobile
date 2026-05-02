import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/models/booking/booking.dart';
import '../../../data/repositoies/booking_repository.dart';

part 'booking_state.dart';
part 'booking_event.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(InitialBookingState()) {
    on<FetchBookingsEvent>(_onFetchDateEvent);
  }

  void _onFetchDateEvent(
    FetchBookingsEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(LoadingBookingState());
    final result = await (await getIt<Future<BookingRepository>>()).bookings();
    result.fold(
      (fail) => emit(FailedBookingState(fail.message)),
      (bookings) => emit(FetchedBookingsState(bookings)),
    );
  }
}
