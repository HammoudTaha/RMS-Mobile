part of 'cancel_booking_bloc.dart';

sealed class CancelBookingState extends Equatable {
  const CancelBookingState();
  @override
  List<Object> get props => [];
}

class InitialCancelBookingState extends CancelBookingState {
  const InitialCancelBookingState();
  @override
  List<Object> get props => [];
}

class LoadingCancelBookingState extends CancelBookingState {
  const LoadingCancelBookingState();
  @override
  List<Object> get props => [];
}

class FailedCancelBookingState extends CancelBookingState {
  final String message;
  const FailedCancelBookingState(this.message);
  @override
  List<Object> get props => [message];
}

class CanceledBookingState extends CancelBookingState {
  final String message;
  const CanceledBookingState(this.message);
  @override
  List<Object> get props => [message];
}
