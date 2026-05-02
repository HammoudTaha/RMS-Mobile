part of 'date_bloc.dart';

sealed class DateEvent {
  const DateEvent();
}

class FetchDateEvent extends DateEvent {
  final DateParams params;
  const FetchDateEvent(this.params);
}

// class FetchBookTimesEvent extends BookEvent {
//   final TimeParams params;
//   const FetchBookTimesEvent(this.params);
// }

// class FetchBookDurationsEvent extends BookEvent {
//   final DurationParams params;
//   const FetchBookDurationsEvent(this.params);
// }

// class FetchBookTablesEvent extends BookEvent {
//   final TableParams params;
//   const FetchBookTablesEvent(this.params);
// }
