part of 'table_bloc.dart';

sealed class TableEvent {
  const TableEvent();
}

class FetchTableEvent extends TableEvent {
  final TableParams params;
  const FetchTableEvent(this.params);
}
