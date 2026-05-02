import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/data_source/remote/book_remote_data_source.dart';
import '../../../data/models/data/date.dart';
import '../../../data/repositories/book_repository.dart';
part 'date_state.dart';
part 'date_event.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(InitialDateState()) {
    on<FetchDateEvent>(_onFetchDateEvent);
  }

  void _onFetchDateEvent(FetchDateEvent event, Emitter<DateState> emit) async {
    emit(LoadingDateState());
    final result = await (await getIt<Future<BookRepository>>()).dates(
      event.params,
    );
    result.fold(
      (fail) => emit(FailedDateState(fail.message)),
      (date) => emit(FetchedDateState(date)),
    );
  }
}
