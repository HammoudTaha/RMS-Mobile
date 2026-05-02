import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../../restaurant/data/models/restaurant/restaurant.dart';
import '../../../data/repositories/favorite_repository.dart';
part 'favorite_state.dart';
part 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(InitialFavoriteState()) {
    on<IsFavoriteEvent>(_onIsFavoriteEvent);
    on<AddFavoriteEvent>(_onAddFavoriteEvent);
    on<FetchFavoriteEvent>(_onFetchFavoriteEvent);
    on<RemoveFavoriteEvent>(_onRemoveFavoriteEvent);
  }

  void _onFetchFavoriteEvent(
    FetchFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(LoadingFavoriteState());
    final result = (await getIt<Future<FavoriteRepository>>()).fetchFavorite();
    result.fold(
      (fail) => emit(FailedFavoriteState(fail.message)),
      (restaurantas) => emit(FetchedFavoriteState(restaurantas)),
    );
  }

  void _onAddFavoriteEvent(
    AddFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(LoadingFavoriteState());
    final result = (await getIt<Future<FavoriteRepository>>()).addFavorite(
      event.restaurant,
    );
    result.fold(
      (fail) => emit(FailedFavoriteState(fail.message)),
      (_) => emit(FavoritedState(true)),
    );
  }

  void _onRemoveFavoriteEvent(
    RemoveFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(LoadingFavoriteState());
    final result = (await getIt<Future<FavoriteRepository>>()).removeFavorite(
      event.id.toString(),
    );
    result.fold(
      (fail) => emit(FailedFavoriteState(fail.message)),
      (_) => emit(FavoritedState(false)),
    );
  }

  void _onIsFavoriteEvent(
    IsFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(LoadingFavoriteState());
    final result = (await getIt<Future<FavoriteRepository>>()).isFavorite(
      event.id.toString(),
    );
    result.fold(
      (fail) => emit(FailedFavoriteState(fail.message)),
      (isFavorited) => emit(FavoritedState(isFavorited)),
    );
  }
}
