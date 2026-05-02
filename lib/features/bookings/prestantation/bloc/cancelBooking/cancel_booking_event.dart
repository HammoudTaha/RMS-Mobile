part of 'cancel_booking_bloc.dart';

sealed class CancelBookingEvent {
  const CancelBookingEvent();
}

class CancelBookEvent extends CancelBookingEvent {
  final String bookId;
  const CancelBookEvent(this.bookId);
}
