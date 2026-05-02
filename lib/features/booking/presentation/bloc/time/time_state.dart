part of 'time_bloc.dart';

sealed class TimeState extends Equatable {
  const TimeState();
  @override
  List<Object> get props => [];
}

class InitialTimeState extends TimeState {
  const InitialTimeState();
  @override
  List<Object> get props => [];
}

class LoadingTimeState extends TimeState {
  const LoadingTimeState();
  @override
  List<Object> get props => [];
}

class FailedTimeState extends TimeState {
  final String message;
  const FailedTimeState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedTimeState extends TimeState {
  final Time time;
  const FetchedTimeState(this.time);
  @override
  List<Object> get props => [time];
}
