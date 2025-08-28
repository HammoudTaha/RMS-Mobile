import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_managment_mobile/features/auth/data/data_source/local/user_local_data_source.dart';
import 'package:restaurant_managment_mobile/features/ordering/presentation/view/success_order_view.dart';
import '../../../features/auth/presentation/widgets/checking_user_view.dart';
import '../../../features/booking/data/data_source/remote/book_remote_data_source.dart';
import '../../../features/booking/presentation/bloc/date/date_bloc.dart';
import '../../../features/booking/presentation/bloc/duration/duration_bloc.dart';
import '../../../features/booking/presentation/bloc/time/time_bloc.dart';
import '../../../features/booking/presentation/view/review_summary_view.dart';
import '../../../features/booking/presentation/view/success_book_table_view.dart';
import '../../../features/cart/presentation/bloc/cart/cart_bloc.dart';
import '../../../features/favorite/presentation/bloc/favorite/favorite_bloc.dart';
import '../../../features/home/presentaion/bloc/search/search_bloc.dart';
import '../../../features/home/presentaion/view/category_restaurant_view.dart';
import '../../../features/home/presentaion/view/search_view.dart';
import '../../../features/ordering/presentation/view/review_summary_view.dart';
import '../../../features/ordering/presentation/view/select_address_view.dart';
import '../../../features/ordering/presentation/view/select_booking_view.dart';
import '../../../features/orders/presentation/bloc/order/order_bloc.dart';
import '../../../features/orders/presentation/view/order_details_view.dart';
import '../../../features/cart/presentation/view/cart_view.dart';
import '../../../features/main/view/main_view.dart';
import '../../../features/auth/presentation/view/login_view.dart';
import '../../../features/auth/presentation/view/register_view.dart';
import '../../../features/auth/presentation/view/forget_password_view.dart';
import '../../../features/auth/presentation/view/confirmation_view.dart';
import '../../../features/auth/presentation/view/reset_password_view.dart';
import '../../../features/profile/presentation/view/profile_update_view.dart';
import '../../../features/restaurant/data/models/restaurant/restaurant.dart';
import '../../../features/restaurant/presentation/view/restaurant_view.dart';
import '../../../features/booking/presentation/view/data_time_guests_view.dart';
import '../../../features/booking/presentation/view/table_view.dart';
import '../../../features/onBoarding/view/onBoarding_view.dart';
import '../../services/di/service_locator.dart';
import '../../utils/keys.dart';

final routers = GoRouter(
  initialLocation: '/main',
  navigatorKey: navigatorStateKey,
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginView();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        return const RegisterView();
      },
    ),
    GoRoute(
      path: '/forget-password',
      builder: (context, state) {
        return const ForgetPasswordView();
      },
    ),
    GoRoute(
      path: '/confirmation',
      builder: (context, state) {
        Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        return ConfirmationView(
          isRegister: data['is_register'],
          info: data['info'],
        );
      },
    ),
    GoRoute(
      path: '/checking-user',
      builder: (context, state) {
        Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        return CheckingUserView(info: data);
      },
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) {
        Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        return ResetPasswordView(info: data);
      },
    ),
    GoRoute(
      path: '/category-restaurant',
      builder: (context, state) {
        final int id = state.extra as int;
        return CategoryRestaurantView(categoryId: id);
      },
    ),
    GoRoute(
      path: '/restaurant',
      builder: (context, state) {
        final String id = state.extra as String;
        return BlocProvider(
          create: (context) => FavoriteBloc(),
          child: RestaurantView(restaurantId: id),
        );
      },
    ),
    GoRoute(
      path: '/data-time-guests',
      builder: (context, state) {
        final restaurant = state.extra as Restaurant;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => DateBloc()),
            BlocProvider(create: (context) => TimeBloc()),
            BlocProvider(create: (context) => DurationBloc()),
          ],
          child: DataTimeGuestsView(restaurant: restaurant),
        );
      },
    ),
    GoRoute(
      path: '/table',
      builder: (context, state) {
        final tableParams = state.extra as TableParams;
        return TableView(tableParams: tableParams);
      },
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => SearchBloc(),
          child: const SearchView(),
        );
      },
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) {
        return const OnBoardingView();
      },
    ),
    GoRoute(
      path: '/main',
      redirect: (context, state) async {
        return (await (await getIt<Future<UserLocalDataSource>>())
                .getIsLogedInUser())
            ? state.matchedLocation
            : '/login';
      },
      builder: (context, state) {
        final int? initialPage = state.extra as int?;
        return initialPage != null
            ? MainView(initialPage: initialPage)
            : const MainView();
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => CartBloc()..add(FetchCartEvent()),
          child: const CartView(),
        );
      },
    ),
    GoRoute(
      path: '/order-details',
      builder: (context, state) {
        final orderId = state.extra as String;
        return OrderDetailsView(orderId: orderId);
      },
    ),
    GoRoute(
      path: '/review-summary-booking',
      builder: (context, state) {
        final params = state.extra as BookParams;
        return ReviewSummaryBookingView(params: params);
      },
    ),
    GoRoute(
      path: '/success-book-table',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return SuccessBookTableView(data: data);
      },
    ),
    GoRoute(
      path: '/profile-update',
      builder: (context, state) {
        final image = state.extra as String?;
        return ProfileUpdateView(image: image);
      },
    ),
    GoRoute(
      path: '/select-address',
      builder: (context, state) {
        return const SelectAddressView();
      },
    ),
    GoRoute(
      path: '/select-booking',
      builder: (context, state) {
        return SelectBookingView();
      },
    ),

    GoRoute(
      path: '/review-summary-ordering',
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CartBloc()..add(FetchCartEvent()),
            ),
            BlocProvider(create: (context) => OrderBloc()),
          ],
          child: const ReviewSummaryOrderingView(),
        );
      },
    ),
    GoRoute(
      path: '/success-order',
      builder: (context, state) {
        Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        return SuccessOrderView(data: data);
      },
    ),
  ],
);
