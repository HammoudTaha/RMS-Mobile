import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'core/public/bloc/translate/translate_bloc.dart';
import 'core/public/routers/routers.dart';
import 'core/services/di/service_locator.dart';
import 'core/utils/custom_snakbar.dart';
import 'features/auth/data/data_source/local/user_local_data_source.dart';
import 'features/auth/data/models/user/user.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/booking/presentation/bloc/book/book_bloc.dart';
import 'features/booking/presentation/bloc/table/table_bloc.dart';
import 'features/bookings/prestantation/bloc/booking/booking_bloc.dart';
import 'features/home/presentaion/bloc/category/category_bloc.dart';
import 'features/ordering/presentation/bloc/delivery_address/delivery_address_bloc.dart';
import 'features/ordering/presentation/bloc/pass_data/pass_data_bloc.dart';
import 'features/orders/presentation/bloc/order/order_bloc.dart';
import 'features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'features/restaurant/presentation/bloc/menu/menu_bloc.dart';
import 'features/restaurant/presentation/bloc/restaurant/restaurant_bloc.dart'
    as restaurant;
import 'features/home/presentaion/bloc/restaurant/restaurant_bloc.dart'
    as restaurants;

class RestaurantApp extends StatefulWidget {
  const RestaurantApp({super.key});

  @override
  State<RestaurantApp> createState() => _RestaurantAppState();
}

class _RestaurantAppState extends State<RestaurantApp> {
  @override
  void initState() {
    super.initState();
  }

  void test() async {
    getIt<Future<Box<User>>>();
    getIt<Future<UserLocalDataSource>>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TranslateBloc()),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<MenuBloc>()),
        BlocProvider(create: (context) => getIt<restaurant.RestaurantBloc>()),
        BlocProvider(create: (context) => getIt<restaurants.RestaurantBloc>()),
        BlocProvider(create: (context) => PassDataBloc()),
        BlocProvider(
          create:
              (context) =>
                  getIt<DeliveryAddressBloc>()
                    ..add(FetchDeliveryAddressesEvent()),
        ),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => TableBloc()),
        BlocProvider(create: (context) => BookBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => BookingBloc()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        routerConfig: routers,
        scaffoldMessengerKey: scaffoldMessengerStateKey,
        builder: EasyLoading.init(
          builder: (context, child) {
            return BlocConsumer<TranslateBloc, TranslateState>(
              listener: (context, state) {
                if (state is EnglishTranslateState) {
                  context.setLocale(Locale('en'));
                }
                if (state is ArabicTranslateState) {
                  context.setLocale(Locale('ar'));
                }
                if (state is FailedTrnaslateState) {
                  showSnakbar('Failed to translate ');
                }
              },
              builder: (context, state) {
                if (state is LoadingTrnaslateState) {
                  return const Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    ),
                  );
                } else {
                  return child ?? SizedBox();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
