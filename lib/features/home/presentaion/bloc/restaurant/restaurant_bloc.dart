import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../data/models/restaurant/restaurant.dart';
part 'restaurant_state.dart';
part 'restaurant_event.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(InitialRestaurantState()) {
    on<FetchRestaurantsEvent>(_onFetchRestaurantsEvent);
  }

  void _onFetchRestaurantsEvent(
    FetchRestaurantsEvent event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(LoadingRestaurantState());
    final result = await (await getIt<Future<HomeRepository>>()).restaurants(
      event.categoryId,
    );
    result.fold(
      (fail) => emit(FailedRestaurantState(fail.message)),
      (restaurants) => emit(FetchedRestaurantsState(restaurants)),
    );
  }
}
