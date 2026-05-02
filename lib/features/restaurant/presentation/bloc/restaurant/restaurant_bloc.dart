import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/models/restaurant/restaurant.dart';
import '../../../data/repositories/restaurant_repository.dart';
part 'restaurant_state.dart';
part 'restaurant_event.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(InitialRestaurantState()) {
    on<FetchRestaurantEvent>(_onFetchRestaurantEvent);
  }

  void _onFetchRestaurantEvent(
    FetchRestaurantEvent event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(LoadingRestaurantState());
    final result = await (await getIt<Future<RestaurantRepository>>())
        .restaurant(event.id);
    result.fold(
      (fail) => emit(FailedRestaurantState(fail.message)),
      (restaurantas) => emit(FetchedRestaurantState(restaurantas)),
    );
  }
}
