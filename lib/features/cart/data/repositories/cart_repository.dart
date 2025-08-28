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
    final favorites = _cartLocalDataSource.fetchCart();
    return favorites.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, NoParams> addCart(Cart cart) {
    final favorites = _cartLocalDataSource.addCart(cart);
    return favorites.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<Cart>> removeCart(String menuId) {
    final favorites = _cartLocalDataSource.removeCart(menuId);
    return favorites.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, bool> isExistCart(Menu menu) {
    final isfavorite = _cartLocalDataSource.isExistCart(menu);
    return isfavorite.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<Cart>> plusQuantityCart(String menuId) {
    final isfavorite = _cartLocalDataSource.plusQuantityCart(menuId);
    return isfavorite.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<Cart>> minusQuantityCart(String menuId) {
    final isfavorite = _cartLocalDataSource.minusQuantityCart(menuId);
    return isfavorite.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<Cart>> addNoteCart(String menuId, String note) {
    final isfavorite = _cartLocalDataSource.addNote(menuId, note);
    return isfavorite.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Failure, List<Cart>> cancelNoteCart(String menuId) {
    final isfavorite = _cartLocalDataSource.cancelNote(menuId);
    return isfavorite.fold((l) => Left(l), (r) => Right(r));
  }
}
