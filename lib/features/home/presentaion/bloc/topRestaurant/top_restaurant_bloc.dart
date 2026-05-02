import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/models/restaurant/restaurant.dart';
import '../../../data/repositories/home_repository.dart';
part 'top_restaurant_state.dart';
part 'top_restaurant_event.dart';

class TopRestarantBloc extends Bloc<TopRestarantEvent, TopRestarantState> {
  TopRestarantBloc() : super(InitialTopRestarantState()) {
    on<FetchTopRestarantsEvent>(_onFetchTopRestarantsEvent);
  }

  void _onFetchTopRestarantsEvent(
    FetchTopRestarantsEvent event,
    Emitter<TopRestarantState> emit,
  ) async {
    emit(LoadingTopRestarantState());
    final result =
        await (await getIt<Future<HomeRepository>>()).topRestaurants();
    result.fold(
      (fail) => emit(FailedTopRestarantState(fail.message)),
      (categories) => emit(FetchedTopRestarantsState(categories)),
    );
  }
}
