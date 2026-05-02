part of 'translate_bloc.dart';

sealed class TranslateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArabicTranslateEvent extends TranslateEvent {}

class EnglishTranslateEvent extends TranslateEvent {}
