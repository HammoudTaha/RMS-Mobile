import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/data_source/remote/book_remote_data_source.dart';
import '../../../data/repositories/book_repository.dart';
import '../../../data/models/duration/duration.dart';
part 'duration_state.dart';
part 'duration_event.dart';

class DurationBloc extends Bloc<DurationEvent, DurationState> {
  DurationBloc() : super(InitialDurationState()) {
    on<FetchDurationEvent>(_onFetchDurationEvent);
  }

  void _onFetchDurationEvent(
    FetchDurationEvent event,
    Emitter<DurationState> emit,
  ) async {
    emit(LoadingDurationState());
    final result = await (await getIt<Future<BookRepository>>()).durations(
      event.params,
    );
    result.fold(
      (fail) => emit(FailedDurationState(fail.message)),
      (duration) => emit(FetchedDurationState(duration)),
    );
  }

}
