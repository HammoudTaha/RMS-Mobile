part of 'date_bloc.dart';

sealed class DateState extends Equatable {
  const DateState();
  @override
  List<Object> get props => [];
}

class InitialDateState extends DateState {
  const InitialDateState();
  @override
  List<Object> get props => [];
}

class LoadingDateState extends DateState {
  const LoadingDateState();
  @override
  List<Object> get props => [];
}

class FailedDateState extends DateState {
  final String message;
  const FailedDateState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedDateState extends DateState {
  final Date date;
  const FetchedDateState(this.date);
  @override
  List<Object> get props => [date];
}

// class FetchedBookTimesState extends BookState {
//   final List<Time> times;
//   const FetchedBookTimesState(this.times);
//   @override
//   List<Object> get props => [times];
// }

// class FetchedBookDurationsState extends BookState {
//   final List<Duration> durations;
//   const FetchedBookDurationsState(this.durations);
//   @override
//   List<Object> get props => [durations];
// }

// class FetchedBookTablesState extends BookState {
//   final List<Table> tables;
//   const FetchedBookTablesState(this.tables);
//   @override
//   List<Object> get props => [tables];
// }
