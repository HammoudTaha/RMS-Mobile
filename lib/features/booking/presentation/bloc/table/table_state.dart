part of 'table_bloc.dart';

sealed class TableState extends Equatable {
  const TableState();
  @override
  List<Object> get props => [];
}

class InitialTableState extends TableState {
  const InitialTableState();
  @override
  List<Object> get props => [];
}

class LoadingTableState extends TableState {
  const LoadingTableState();
  @override
  List<Object> get props => [];
}

class FailedTableState extends TableState {
  final String message;
  const FailedTableState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedTableState extends TableState {
  final List<Table> tables;
  const FetchedTableState(this.tables);
  @override
  List<Object> get props => [tables];
}
