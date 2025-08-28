import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/di/service_locator.dart';
import '../../../../restaurant/data/models/menu/menu.dart';
import '../../../data/models/cart/cart.dart';
import '../../../data/repositories/cart_repository.dart';
part 'cart_state.dart';
part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitialCartState()) {
    on<AddCartEvent>(_onAddCartEvent);
    on<FetchCartEvent>(_onFetchCartEvent);
    on<RemoveCartEvent>(_onRemoveCartEvent);
    on<IsExistCartEvent>(_onIsExistCartEvent);
    on<AddNoteCartEvent>(_onEidtNoteCartEvent);
    on<CancelNoteCartEvent>(_onCancelNoteCartEvent);
    on<PlusQuantityCartEvent>(_onPlusCartQuantityCartEvent);
    on<MinusQuantityCartEvent>(_onMinusCartQuantityCartEvent);
  }

  void _onFetchCartEvent(FetchCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingCartState());
    final result = (await getIt<Future<CartRepository>>()).fetchCart();
    result.fold(
      (fail) => emit(FailedCartState(fail.message)),
      (carts) => emit(FetchedCartState(carts)),
    );
  }

  void _onAddCartEvent(AddCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingCartState());
    final result = (await getIt<Future<CartRepository>>()).addCart(event.cart);
    result.fold((fail) => emit(FailedCartState(fail.message)), (_) {});
  }

  void _onRemoveCartEvent(
    RemoveCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(LoadingCartState());
    final result = (await getIt<Future<CartRepository>>()).removeCart(event.id);
    result.fold(
      (fail) => emit(FailedCartState(fail.message)),
      (carts) => emit(FetchedCartState(carts)),
    );
  }

  void _onIsExistCartEvent(
    IsExistCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(LoadingCartState());
    final result = (await getIt<Future<CartRepository>>()).isExistCart(
      event.menu,
    );
    result.fold(
      (fail) => emit(FailedCartState(fail.message)),
      (isExist) => emit(ExistedCartState(isExist)),
    );
  }

  void _onPlusCartQuantityCartEvent(
    PlusQuantityCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(LoadingCartState());
    final result = (await getIt<Future<CartRepository>>()).plusQuantityCart(
      event.id,
    );
    result.fold(
      (fail) => emit(FailedCartState(fail.message)),
      (carts) => emit(FetchedCartState(carts)),
    );
  }

  void _onMinusCartQuantityCartEvent(
    MinusQuantityCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(LoadingCartState());
    final result = (await getIt<Future<CartRepository>>()).minusQuantityCart(
      event.id,
    );
    result.fold(
      (fail) => emit(FailedCartState(fail.message)),
      (carts) => emit(FetchedCartState(carts)),
    );
  }

  void _onEidtNoteCartEvent(
    AddNoteCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(LoadingCartState());
    final result = (await getIt<Future<CartRepository>>()).addNoteCart(
      event.id,
      event.note,
    );
    result.fold(
      (fail) => emit(FailedCartState(fail.message)),
      (carts) => emit(FetchedCartState(carts)),
    );
  }

  void _onCancelNoteCartEvent(
    CancelNoteCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(LoadingCartState());
    final result = (await getIt<Future<CartRepository>>()).cancelNoteCart(
      event.id,
    );
    result.fold(
      (fail) => emit(FailedCartState(fail.message)),
      (carts) => emit(FetchedCartState(carts)),
    );
  }
}
