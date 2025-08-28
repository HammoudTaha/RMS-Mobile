part of 'time_bloc.dart';

sealed class TimeEvent {
  const TimeEvent();
}

class FetchTimeEvent extends TimeEvent {
  final TimeParams params;
  const FetchTimeEvent(this.params);
}

// class FetchBookDurationsEvent extends BookEvent {
//   final DurationParams params;
//   const FetchBookDurationsEvent(this.params);
// }

// class FetchBookTablesEvent extends BookEvent {
//   final TableParams params;
//   const FetchBookTablesEvent(this.params);
// }
