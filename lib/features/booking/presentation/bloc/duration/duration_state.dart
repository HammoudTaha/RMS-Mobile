part of 'duration_bloc.dart';

sealed class DurationState extends Equatable {
  const DurationState();
  @override
  List<Object> get props => [];
}

class InitialDurationState extends DurationState {
  const InitialDurationState();
  @override
  List<Object> get props => [];
}

class LoadingDurationState extends DurationState {
  const LoadingDurationState();
  @override
  List<Object> get props => [];
}

class FailedDurationState extends DurationState {
  final String message;
  const FailedDurationState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedDurationState extends DurationState {
  final Duration duration;
  const FetchedDurationState(this.duration);
  @override
  List<Object> get props => [duration];
}
