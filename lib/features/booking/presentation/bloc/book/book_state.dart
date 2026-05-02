part of 'book_bloc.dart';

sealed class BookState extends Equatable {
  const BookState();
  @override
  List<Object> get props => [];
}

class InitialBookState extends BookState {
  const InitialBookState();
  @override
  List<Object> get props => [];
}

class LoadingBookState extends BookState {
  const LoadingBookState();
  @override
  List<Object> get props => [];
}

class FailedBookState extends BookState {
  final String message;
  const FailedBookState(this.message);
  @override
  List<Object> get props => [message];
}

class BookedState extends BookState {
  final Map<String, dynamic> data;
  const BookedState(this.data);
  @override
  List<Object> get props => [data];
}
