import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'translate_state.dart';
part 'translate_event.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc() : super(EnglishTranslateState()) {
    on<EnglishTranslateEvent>((event, emit) async {
      emit(LoadingTrnaslateState());
      await Future.delayed(Duration(seconds: 1)).then((value) {
        emit(EnglishTranslateState());
      });
    });
    on<ArabicTranslateEvent>((event, emit) async {
      emit(LoadingTrnaslateState());
      await Future.delayed(Duration(seconds: 1)).then((value) {
        emit(ArabicTranslateState());
      });
    });
  }
}
