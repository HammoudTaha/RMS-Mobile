import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/data_source/remote/book_remote_data_source.dart';
import '../../../data/models/time/time.dart';
import '../../../data/repositories/book_repository.dart';
part 'time_state.dart';
part 'time_event.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(InitialTimeState()) {
    on<FetchTimeEvent>(_onFetchTimeEvent);
  }

  void _onFetchTimeEvent(FetchTimeEvent event, Emitter<TimeState> emit) async {
    emit(LoadingTimeState());
    final result = await (await getIt<Future<BookRepository>>()).times(
      event.params,
    );
    result.fold(
      (fail) => emit(FailedTimeState(fail.message)),
      (time) => emit(FetchedTimeState(time)),
    );
  }





}
