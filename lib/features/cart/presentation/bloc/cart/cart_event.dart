part of 'cart_bloc.dart';

sealed class CartEvent {
  const CartEvent();
}

class FetchCartEvent extends CartEvent {
  const FetchCartEvent();
}

class AddCartEvent extends CartEvent {
  final Cart cart;
  const AddCartEvent(this.cart);
}

class RemoveCartEvent extends CartEvent {
  final String id;
  const RemoveCartEvent(this.id);
}

class IsExistCartEvent extends CartEvent {
  final Menu menu;
  const IsExistCartEvent(this.menu);
}

class PlusQuantityCartEvent extends CartEvent {
  final String id;
  const PlusQuantityCartEvent(this.id);
}

class MinusQuantityCartEvent extends CartEvent {
  final String id;
  const MinusQuantityCartEvent(this.id);
}

class AddNoteCartEvent extends CartEvent {
  final String id;
  final String note;
  const AddNoteCartEvent({required this.id, required this.note});
}

class CancelNoteCartEvent extends CartEvent {
  final String id;
  const CancelNoteCartEvent(this.id);
}
