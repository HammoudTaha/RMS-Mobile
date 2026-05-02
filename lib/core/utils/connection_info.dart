import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:restaurant_managment_mobile/core/utils/custom_snakbar.dart';

class ConnectionInfo {
  final Connectivity connectivity;
  ConnectionInfo(this.connectivity);
  Future<bool> checkConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    }
    return false;
  }

  void oChangeConnection() {
    connectivity.onConnectivityChanged.listen((event) {
      if (event.contains(ConnectivityResult.none)) {
        showSnakbar('You are currently offline');
      } else {
        showSnakbar('Your connection internet was restored');
      }
    });
  }
}
