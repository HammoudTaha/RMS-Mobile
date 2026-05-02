import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/data/data_source/remote/user_remote_data_source.dart';
import '../../../restaurant/data/models/menu/menu.dart';
import '../data_source/local/cart_local_data_source.dart';
import '../models/cart/cart.dart';

class CartRepository {
  final CartLocalDataSource _cartLocalDataSource;
  CartRepository(this._cartLocalDataSource);

  Either<Failure, List<Cart>> fetchCart() {
    final carts = _cartLocalDataSource.fetchCart();
    return carts.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, NoParams> addCart(Cart cart) {
    final resualt = _cartLocalDataSource.addCart(cart);
    return resualt.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<Cart>> removeCart(String menuId) {
    final carts = _cartLocalDataSource.removeCart(menuId);
    return carts.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, bool> isExistCart(Menu menu) {
    final isExist = _cartLocalDataSource.isExistCart(menu);
    return isExist.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<Cart>> plusQuantityCart(String menuId) {
    final carts = _cartLocalDataSource.plusQuantityCart(menuId);
    return carts.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<Cart>> minusQuantityCart(String menuId) {
    final carts = _cartLocalDataSource.minusQuantityCart(menuId);
    return carts.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<Cart>> addNoteCart(String menuId, String note) {
    final carts = _cartLocalDataSource.addNote(menuId, note);
    return carts.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<Cart>> cancelNoteCart(String menuId) {
    final carts = _cartLocalDataSource.cancelNote(menuId);
    return carts.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, NoParams> removeAllCarts() {
    final resualt = _cartLocalDataSource.removeAllCart();
    return resualt.fold((l) => Left(l), (r) => Right(r));
  }
}
