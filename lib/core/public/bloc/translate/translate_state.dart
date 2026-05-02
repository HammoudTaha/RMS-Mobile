part of 'translate_bloc.dart';

sealed class TranslateState extends Equatable {
  const TranslateState();
  @override
  List<Object?> get props => [];
}

class LoadingTrnaslateState extends TranslateState {
  const LoadingTrnaslateState();
}

class FailedTrnaslateState extends TranslateState {
  const FailedTrnaslateState();
}

class EnglishTranslateState extends TranslateState {
  const EnglishTranslateState();
}

class ArabicTranslateState extends TranslateState {
  const ArabicTranslateState();
}
