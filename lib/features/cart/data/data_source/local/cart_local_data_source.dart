import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/local_service/local_storage.dart';
import '../../../../auth/data/data_source/remote/user_remote_data_source.dart';
import '../../../../restaurant/data/models/menu/menu.dart';
import '../../models/cart/cart.dart';

class CartLocalDataSource {
  final LocalStorage<Cart> _cartLocalStorage;

  CartLocalDataSource(this._cartLocalStorage);

  Either<Failure, List<Cart>> fetchCart() {
    try {
      List<Cart> carts = _cartLocalStorage.get();
      return Right(carts);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, NoParams> addCart(Cart cart) {
    try {
      _cartLocalStorage.store(cart);
      return Right(NoParams());
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, List<Cart>> removeCart(String menuId) {
    try {
      List<Cart> carts = _cartLocalStorage.get();
      int index = carts.indexWhere((element) => element.menu.id == menuId);
      _cartLocalStorage.delete(index);
      carts.removeAt(index);
      return Right(carts);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, bool> isExistCart(Menu menu) {
    try {
      List<Cart> carts = _cartLocalStorage.get();
      if (carts.isEmpty || carts.first.menu.restaurantId == menu.restaurantId) {
        final isExist =
            carts.where((element) => element.menu.id == menu.id).isNotEmpty;
        return Right(isExist);
      } else {
        return Left(
          Failure(
            message: "You can't add items from different restaurants to cart",
          ),
        );
      }
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, List<Cart>> plusQuantityCart(String menuId) {
    try {
      List<Cart> carts = _cartLocalStorage.get();
      int index = carts.indexWhere((element) => element.menu.id == menuId);
      Cart cart = carts.elementAt(index);
      cart = cart.copyWith(quantity: cart.quantity + 1);
      carts[index] = cart;
      for (int i = 0; i < carts.length; i++) {
        removeCart(carts[i].menu.id);
      }
      for (int i = 0; i < carts.length; i++) {
        addCart(carts[i]);
      }
      return Right(carts);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, List<Cart>> minusQuantityCart(String menuId) {
    try {
      List<Cart> carts = _cartLocalStorage.get();
      int index = carts.indexWhere((element) => element.menu.id == menuId);
      Cart cart = carts.elementAt(index);
      cart = cart.copyWith(quantity: cart.quantity - 1);
      carts[index] = cart;
      for (int i = 0; i < carts.length; i++) {
        removeCart(carts[i].menu.id);
      }
      for (int i = 0; i < carts.length; i++) {
        addCart(carts[i]);
      }
      return Right(carts);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, List<Cart>> addNote(String menuId, String note) {
    try {
      List<Cart> carts = _cartLocalStorage.get();
      int index = carts.indexWhere((element) => element.menu.id == menuId);
      Cart cart = carts.elementAt(index);
      cart = cart.copyWith(note: note);
      carts[index] = cart;
      for (int i = 0; i < carts.length; i++) {
        removeCart(carts[i].menu.id);
      }
      for (int i = 0; i < carts.length; i++) {
        addCart(carts[i]);
      }
      return Right(carts);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }

  Either<Failure, List<Cart>> cancelNote(String menuId) {
    try {
      List<Cart> carts = _cartLocalStorage.get();
      int index = carts.indexWhere((element) => element.menu.id == menuId);
      Cart cart = carts.elementAt(index);
      cart = cart.copyWith(note: null);
      carts[index] = cart;
      for (int i = 0; i < carts.length; i++) {
        removeCart(carts[i].menu.id);
      }
      for (int i = 0; i < carts.length; i++) {
        addCart(carts[i]);
      }
      return Right(carts);
    } on Exception catch (_) {
      return Left(Failure(message: 'Something went wrong .Please try again'));
    }
  }
}
