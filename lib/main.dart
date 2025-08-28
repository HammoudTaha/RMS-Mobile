import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'app.dart';
import 'core/services/di/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await initServiceLocator();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      startLocale: Locale('en'),
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const RestaurantApp(),
    ),
  );
}
