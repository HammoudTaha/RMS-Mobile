import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_error_page.dart';
import '../bloc/favorite/favorite_bloc.dart';
import '../widgets/custom_favorites_item.dart';
import '../widgets/custom_no_favorite_item.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    context.read<FavoriteBloc>().add(FetchFavoriteEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Favorite',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FetchedFavoriteState) {
              if (state.restaurant.isEmpty) {
                return const CustomNoFavoriteItem();
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemCount: state.restaurant.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomFavoritesItem(
                        restaurant: state.restaurant[index],
                      ),
                    );
                  },
                );
              }
            } else if (state is FailedFavoriteState) {
              return CustomErrorPage(
                onRetry: () {
                  context.read<FavoriteBloc>().add(FetchFavoriteEvent());
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
