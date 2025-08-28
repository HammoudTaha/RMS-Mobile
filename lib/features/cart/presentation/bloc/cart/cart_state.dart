part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
  @override
  List<Object> get props => [];
}

class InitialCartState extends CartState {
  const InitialCartState();
  @override
  List<Object> get props => [];
}

class LoadingCartState extends CartState {
  const LoadingCartState();
  @override
  List<Object> get props => [];
}

class FailedCartState extends CartState {
  final String message;
  const FailedCartState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedCartState extends CartState {
  final List<Cart> carts;
  const FetchedCartState(this.carts);
  @override
  List<Object> get props => [carts];
}

class ExistedCartState extends CartState {
  final bool isExist;
  const ExistedCartState(this.isExist);
  @override
  List<Object> get props => [isExist];
}
