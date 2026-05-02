import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/data_source/remote/book_remote_data_source.dart';
import '../../../data/models/table/table.dart';
import '../../../data/repositories/book_repository.dart';
part 'table_state.dart';
part 'table_event.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  TableBloc() : super(InitialTableState()) {
    on<FetchTableEvent>(_onFetchTimeEvent);
  }

  void _onFetchTimeEvent(
    FetchTableEvent event,
    Emitter<TableState> emit,
  ) async {
    emit(LoadingTableState());
    final result = await (await getIt<Future<BookRepository>>()).tables(
      event.params,
    );
    result.fold(
      (fail) => emit(FailedTableState(fail.message)),
      (times) => emit(FetchedTableState(times)),
    );
  }
}
