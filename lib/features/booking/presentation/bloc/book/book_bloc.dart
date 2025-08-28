import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/data_source/remote/book_remote_data_source.dart';
import '../../../data/repositories/book_repository.dart';
part 'book_state.dart';
part 'book_event.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(InitialBookState()) {
    on<BookEvent>(_onFetchDateEvent);
  }

  void _onFetchDateEvent(BookEvent event, Emitter<BookState> emit) async {
    emit(LoadingBookState());
    final result = await (await getIt<Future<BookRepository>>()).book(
      event.params,
    );
    result.fold(
      (fail) => emit(FailedBookState(fail.message)),
      (data) => emit(BookedState(data)),
    );
  }
}
