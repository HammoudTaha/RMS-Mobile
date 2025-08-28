import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../data/models/restaurant/restaurant.dart';
part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearchState()) {
    on<FetchRestaurantsSearchEvent>(_onFetchRestaurantsEvent);
  }

  void _onFetchRestaurantsEvent(
    FetchRestaurantsSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(LoadingSearchState());
    final result = await (await getIt<Future<HomeRepository>>())
        .restaurantsByName(event.name);
    result.fold(
      (fail) => emit(FailedSearchState(fail.message)),
      (restaurants) => emit(FetchedRestaurantsSearchState(restaurants)),
    );
  }
}
