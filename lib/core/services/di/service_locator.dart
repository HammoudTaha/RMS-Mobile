import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:restaurant_managment_mobile/features/booking/data/data_source/remote/book_remote_data_source.dart';
import 'package:restaurant_managment_mobile/features/booking/data/repositories/book_repository.dart';
import 'package:restaurant_managment_mobile/features/bookings/data/data_source/remote/remote_booking_data_source.dart';
import 'package:restaurant_managment_mobile/features/bookings/data/repositoies/booking_repository.dart';
import '../../../features/cart/data/data_source/local/cart_local_data_source.dart';
import '../../../features/cart/data/models/cart/cart.dart';
import '../../../features/cart/data/repositories/cart_repository.dart';
import '../../../features/favorite/data/data_source/local/favorite_local_data_source.dart';
import '../../../features/favorite/data/repositories/favorite_repository.dart';
import '../../../features/home/data/data_source/remote/home_remote_data_source.dart';
import '../../../features/home/data/repositories/home_repository.dart';
import '../../../features/ordering/data/data_source/local/delivery_address_local_data_source.dart';
import '../../../features/ordering/data/models/delivery_address/delivery_info.dart';
import '../../../features/ordering/data/repositories/delivery_address_repository.dart';
import '../../../features/ordering/presentation/bloc/delivery_address/delivery_address_bloc.dart';
import '../../../features/orders/data/data_source/remote/order_remote_data_source.dart'
    show OrderRemoteDataSource;
import '../../../features/orders/data/repositories/order_repository.dart';
import '../../../features/profile/data/data_source/local/profile_local_data_source.dart';
import '../../../features/profile/data/data_source/remote/profile_remote_data_source.dart';
import '../../../features/profile/data/repositories/profile_repository.dart';
import '../../../features/restaurant/data/data_source/remote/restaurant_remote_data_source.dart';
import '../../../features/restaurant/data/models/menu/menu.dart';
import '../../../features/restaurant/data/models/restaurant/restaurant.dart';
import '../../../features/restaurant/data/repositories/restaurant_repository.dart';
import '../../../features/restaurant/presentation/bloc/menu/menu_bloc.dart';
import '../local_service/local_storage.dart';
import '../local_service/secure_storage.dart';
import '../../../features/auth/data/data_source/local/user_local_data_source.dart';
import '../../../features/auth/data/data_source/remote/user_remote_data_source.dart';
import '../../../features/auth/data/models/user/user.dart';
import '../../../features/auth/data/repositories/auth_repository.dart';
import '../../../features/auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../features/restaurant/presentation/bloc/restaurant/restaurant_bloc.dart'
    as restaurant;
import '../../constants/strings.dart';
import '../../utils/connection_info.dart';
import '../../utils/custom_pretty_dio_logger.dart';
import '../api-service/api_intercepter.dart';
import '../api-service/api_service.dart';
import '../../../features/home/presentaion/bloc/restaurant/restaurant_bloc.dart'
    as restaurants;

final getIt = GetIt.instance;
Future<void> initServiceLocator() async {
  //dio
  getIt.registerLazySingleton(
    () =>
        Dio()
          ..interceptors.addAll([
            getIt<ApiIntercepter>(),
            customPrettyDioLogger,
          ])
          ..options.baseUrl = AppStrings.baseUrl
          ..options.connectTimeout = const Duration(seconds: 10),
  );

  //connection
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton(
    () => ConnectionInfo(getIt<Connectivity>())..oChangeConnection(),
  );

  //secure storage
  getIt.registerLazySingleton(() => FlutterSecureStorage());

  //dio intercepter
  getIt.registerLazySingleton(
    () => ApiIntercepter(
      getIt<SecureStorage>(),
      Dio()
        ..interceptors.add(customPrettyDioLogger)
        ..options.baseUrl = AppStrings.baseUrl,
    ),
  );

  //api service
  getIt.registerLazySingleton(() => ApiService(getIt<Dio>()));

  //user box
  getIt.registerLazySingleton<Future<Box<User>>>(() {
    Hive.registerAdapter(UserAdapter());
    return Hive.openBox<User>(AppStrings.userBox);
  });

  //service secure local storage
  getIt.registerLazySingleton(
    () => SecureStorage(getIt<FlutterSecureStorage>()),
  );

  //service user local storage
  getIt.registerLazySingleton<Future<LocalStorage<User>>>(
    () async => LocalStorage(await getIt<Future<Box<User>>>()),
  );

  //user local data source
  getIt.registerLazySingleton<Future<UserLocalDataSource>>(
    () async => UserLocalDataSource(
      await getIt<Future<LocalStorage<User>>>(),
      getIt<SecureStorage>(),
    ),
  );

  //user remote data source
  getIt.registerLazySingleton(() => UserRemoteDataSource(getIt<ApiService>()));

  //user repository
  getIt.registerLazySingleton(
    () async => AuthRepository(
      await getIt<Future<UserLocalDataSource>>(),
      getIt<UserRemoteDataSource>(),
      getIt<ConnectionInfo>(),
    ),
  );

  //auth bloc
  getIt.registerLazySingleton(() => AuthBloc());

  //profile info local storage
  getIt.registerLazySingleton<Future<ProfileLocalDataSource>>(
    () async =>
        ProfileLocalDataSource(await getIt<Future<LocalStorage<User>>>()),
  );

  //profile info remote storage
  getIt.registerLazySingleton(
    () => ProfileRemoteDataSource(getIt<ApiService>()),
  );

  //profile repository
  getIt.registerLazySingleton(
    () async => ProfileRepository(
      await getIt<Future<ProfileLocalDataSource>>(),
      getIt<ProfileRemoteDataSource>(),
      getIt<ConnectionInfo>(),
    ),
  );

  //restaurant remote storage
  getIt.registerLazySingleton(
    () => RestaurantRemoteDataSource(getIt<ApiService>()),
  );

  //restaurant repository
  getIt.registerLazySingleton(
    () async => RestaurantRepository(
      getIt<RestaurantRemoteDataSource>(),
      getIt<ConnectionInfo>(),
    ),
  );

  //restaurant bloc
  getIt.registerLazySingleton(() => restaurant.RestaurantBloc());

  //home remote storage
  getIt.registerLazySingleton(() => HomeRemoteDataSource(getIt<ApiService>()));

  //home repository
  getIt.registerLazySingleton(
    () async =>
        HomeRepository(getIt<HomeRemoteDataSource>(), getIt<ConnectionInfo>()),
  );

  //restaurants bloc
  getIt.registerLazySingleton(() => restaurants.RestaurantBloc());

  //restaurant box
  getIt.registerLazySingleton<Future<Box<Restaurant>>>(() {
    Hive.registerAdapter(RestaurantAdapter());
    return Hive.openBox<Restaurant>(AppStrings.restaurantBox);
  });

  //service favorite local storage
  getIt.registerLazySingleton<Future<LocalStorage<Restaurant>>>(
    () async => LocalStorage(await getIt<Future<Box<Restaurant>>>()),
  );

  //favorite local storage
  getIt.registerLazySingleton(
    () async => FavoriteLocalDataSource(
      await getIt<Future<LocalStorage<Restaurant>>>(),
    ),
  );

  //favorite repository
  getIt.registerLazySingleton(
    () async =>
        FavoriteRepository(await getIt<Future<FavoriteLocalDataSource>>()),
  );

  //menu bloc
  getIt.registerLazySingleton(() => MenuBloc());

  //cart box
  getIt.registerLazySingleton<Future<Box<Cart>>>(() {
    Hive.registerAdapter(MenuAdapter());
    Hive.registerAdapter(CartAdapter());
    return Hive.openBox<Cart>(AppStrings.cartBox);
  });

  //service cart local storage
  getIt.registerLazySingleton<Future<LocalStorage<Cart>>>(
    () async => LocalStorage(await getIt<Future<Box<Cart>>>()),
  );

  //cart local storage
  getIt.registerLazySingleton(
    () async => CartLocalDataSource(await getIt<Future<LocalStorage<Cart>>>()),
  );

  //cart repository
  getIt.registerLazySingleton(
    () async => CartRepository(await getIt<Future<CartLocalDataSource>>()),
  );

  //delivery address box
  getIt.registerLazySingleton<Future<Box<DeliveryInfo>>>(() {
    Hive.registerAdapter(DeliveryInfoAdapter());
    return Hive.openBox<DeliveryInfo>(AppStrings.deliveryAddress);
  });

  //service delivery address local storage
  getIt.registerLazySingleton<Future<LocalStorage<DeliveryInfo>>>(
    () async => LocalStorage(await getIt<Future<Box<DeliveryInfo>>>()),
  );

  //delivery address local storage
  getIt.registerLazySingleton(
    () async => DeliveryAddressLocalDataSource(
      await getIt<Future<LocalStorage<DeliveryInfo>>>(),
    ),
  );

  //delivery address repository
  getIt.registerLazySingleton(
    () async => DeliveryAddressRepository(
      await getIt<Future<DeliveryAddressLocalDataSource>>(),
    ),
  );

  //delivery address bloc
  getIt.registerLazySingleton(() => DeliveryAddressBloc());

  //order remote storage
  getIt.registerLazySingleton(() => OrderRemoteDataSource(getIt<ApiService>()));

  //order repository
  getIt.registerLazySingleton(
    () async => OrderRepository(
      getIt<OrderRemoteDataSource>(),
      getIt<ConnectionInfo>(),
    ),
  );

  //book remote storage
  getIt.registerLazySingleton(() => BookRemoteDataSource(getIt<ApiService>()));

  //book repository
  getIt.registerLazySingleton(
    () async =>
        BookRepository(getIt<BookRemoteDataSource>(), getIt<ConnectionInfo>()),
  );

  //booking remote storage
  getIt.registerLazySingleton(
    () => RemoteBookingDataSource(getIt<ApiService>()),
  );

  //booking repository
  getIt.registerLazySingleton(
    () async => BookingRepository(
      getIt<RemoteBookingDataSource>(),
      getIt<ConnectionInfo>(),
    ),
  );
}
