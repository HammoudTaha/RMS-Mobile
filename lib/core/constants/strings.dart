class AppStrings {
  AppStrings._();

  //api
  static const String baseUrl =
      'https://rms-production-7292.up.railway.app/api/';
  static const String profile = 'accounts/profile/';
  static const String login = 'accounts/login/';
  static const String register = 'accounts/register/';
  static const String logout = 'accounts/logout/';
  static const String verfiyPhone = 'accounts/verify-phone/';
  static const String resetPassword = 'accounts/reset-password/';
  static const String sendVerificationCode = 'accounts/send-verification-code/';
  static const String verifyResetCode = 'accounts/verify-reset-code/';
  static const String forgetPassword = 'accounts/forgot-password/';
  static const String verifyToken = 'token/verify/';
  static const String refreshToken = 'token/refresh/';
  static const String updateProfile = 'accounts/profile/update/';
  static const String uploadImage = 'accounts/profile/upload-image/';

  static const String restaurants = 'restaurants/';
  static const String reservations = 'restaurants/reservations/';
  static const String categories = 'restaurants/categories/';

  static const String orders = 'orders/';
  static const String createOrder = 'orders/create/';

  //cash
  static const String cashedAccessToken = 'ACCESS_TOKEN';
  static const String cashedARefreshToken = 'REFRESH_TOKEN';
  static const String cashedUser = 'USER';
  static const String userBox = 'USER_BOX';
  static const String restaurantBox = 'RESTAURNAT_BOX';
  static const String cartBox = 'CART_BOX';
  static const String deliveryAddress = 'DELIVERY_ADDRESS_BOX';
  static const String isLogedInUser = 'IS_LOGED_IN_USER';
}
