part of 'booking_bloc.dart';

sealed class BookingState extends Equatable {
  const BookingState();
  @override
  List<Object> get props => [];
}

class InitialBookingState extends BookingState {
  const InitialBookingState();
  @override
  List<Object> get props => [];
}

class LoadingBookingState extends BookingState {
  const LoadingBookingState();
  @override
  List<Object> get props => [];
}

class FailedBookingState extends BookingState {
  final String message;
  const FailedBookingState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedBookingsState extends BookingState {
  final List<Booking> bookings;
  const FetchedBookingsState(this.bookings);
  @override
  List<Object> get props => [bookings];
}
