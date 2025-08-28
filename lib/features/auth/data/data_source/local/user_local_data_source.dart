import 'package:restaurant_managment_mobile/core/services/local_service/secure_storage.dart';

import '../../../../../core/constants/strings.dart';
import '../../models/user/user.dart';
import '../../../../../core/services/local_service/local_storage.dart';

class UserLocalDataSource {
  final LocalStorage<User> _userBox;
  final SecureStorage _secureStorage;
  const UserLocalDataSource(this._userBox, this._secureStorage);

  void setUser(User user) {
    _userBox.storeKayValue(user, AppStrings.cashedUser);
  }

  User getUser() {
    User user = _userBox.getKeyValue(AppStrings.cashedUser);
    return user;
  }

  void setAccessToken(String value) {
    _secureStorage.set(key: AppStrings.cashedAccessToken, value: value);
  }

  void setRefreshToken(String value) {
    _secureStorage.set(key: AppStrings.cashedARefreshToken, value: value);
  }

  Future<String> getAccessToken() async {
    return await _secureStorage.get(key: AppStrings.cashedAccessToken);
  }

  Future<String> getRefreshToken() async {
    return await _secureStorage.get(key: AppStrings.cashedARefreshToken);
  }

  void setIsLogedInUser(bool value) async {
    _secureStorage.set(key: AppStrings.isLogedInUser, value: value.toString());
  }

  Future<bool> getIsLogedInUser() async {
    try {
      return bool.parse(
        await _secureStorage.get(key: AppStrings.isLogedInUser),
      );
    } on Exception catch (_) {
      return false;
    }
  }

  void clearCash() {
    _userBox.deletKeyValue(AppStrings.cashedUser);
    _secureStorage.clearCach(AppStrings.cashedARefreshToken);
    _secureStorage.clearCach(AppStrings.cashedAccessToken);
  }
}
