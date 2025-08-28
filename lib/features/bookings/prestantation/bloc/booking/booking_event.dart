part of 'booking_bloc.dart';

sealed class BookingEvent {
  const BookingEvent();
}

class FetchBookingsEvent extends BookingEvent {
  const FetchBookingsEvent();
}
