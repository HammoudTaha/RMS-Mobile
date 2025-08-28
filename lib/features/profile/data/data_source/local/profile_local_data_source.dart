import '../../../../../core/constants/strings.dart';
import '../../../../../core/services/local_service/local_storage.dart';
import '../../../../auth/data/models/user/user.dart';

class ProfileLocalDataSource {
  final LocalStorage<User> _userBox;
  const ProfileLocalDataSource(this._userBox);

  void setUser(User user) {
    _userBox.storeKayValue(user, AppStrings.cashedUser);
  }

  User getUser() {
    User user = _userBox.getKeyValue(AppStrings.cashedUser);
    return user;
  }
}
