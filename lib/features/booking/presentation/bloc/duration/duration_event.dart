part of 'duration_bloc.dart';

sealed class DurationEvent {
  const DurationEvent();
}

class FetchDurationEvent extends DurationEvent {
  final DurationParams params;
  const FetchDurationEvent(this.params);
}

// class FetchBookTablesEvent extends BookEvent {
//   final TableParams params;
//   const FetchBookTablesEvent(this.params);
// }
