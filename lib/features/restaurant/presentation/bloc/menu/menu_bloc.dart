import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../data/models/menu/menu.dart';
import '../../../data/repositories/restaurant_repository.dart';

part 'menu_state.dart';
part 'menu_event.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(InitialMenuState()) {
    on<FetchMenuEvent>(_onFetchMenuRestaurantEvent);
  }

  void _onFetchMenuRestaurantEvent(
    FetchMenuEvent event,
    Emitter<MenuState> emit,
  ) async {
    emit(LoadingMenuState());
    final result = await (await getIt<Future<RestaurantRepository>>()).menu(
      event.id,
    );
    result.fold(
      (fail) => emit(FailedMenuState(fail.message)),
      (menu) => emit(FetchedMenuState(menu)),
    );
  }
}
