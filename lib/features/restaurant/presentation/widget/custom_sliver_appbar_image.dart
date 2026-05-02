import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_star_rate.dart';
import '../../../favorite/presentation/bloc/favorite/favorite_bloc.dart';
import '../../data/models/restaurant/restaurant.dart';

class CustomSliverAppBarWithImage extends StatefulWidget {
  const CustomSliverAppBarWithImage({
    super.key,
    required this.scrolled,
    required this.restaurant,
  });
  final Restaurant restaurant;
  final bool scrolled;

  @override
  State<CustomSliverAppBarWithImage> createState() =>
      _CustomSliverAppBarWithImageState();
}

class _CustomSliverAppBarWithImageState
    extends State<CustomSliverAppBarWithImage> {
  @override
  void initState() {
    context.read<FavoriteBloc>().add(
      IsFavoriteEvent(int.parse(widget.restaurant.id)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0.0,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: widget.scrolled ? Colors.black : Colors.white,
        ),
      ),
      floating: true,
      snap: false,
      expandedHeight: 260,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.restaurant.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        titlePadding:
            widget.scrolled
                ? const EdgeInsets.only(left: 50, bottom: 13)
                : const EdgeInsets.only(left: 10, bottom: 60),
        expandedTitleScale: 1,
        background: Column(
          children: [
            Image.asset(
              'assets/images/t4.png',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<FavoriteBloc, FavoriteState>(
                        builder: (context, state) {
                          if (state is FavoritedState) {
                            return IconButton(
                              onPressed: () {
                                if (state.isFavorited) {
                                  context.read<FavoriteBloc>().add(
                                    RemoveFavoriteEvent(
                                      int.parse(widget.restaurant.id),
                                    ),
                                  );
                                } else {
                                  context.read<FavoriteBloc>().add(
                                    AddFavoriteEvent(widget.restaurant),
                                  );
                                }
                              },
                              icon: Icon(
                                state.isFavorited
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline,
                                size: 30,
                              ),
                            );
                          } else {
                            return IconButton(
                              onPressed: () {
                                context.read<FavoriteBloc>().add(
                                  AddFavoriteEvent(widget.restaurant),
                                );
                              },
                              icon: Icon(Icons.bookmark_outline, size: 30),
                            );
                          }
                        },
                        buildWhen: (previous, current) {
                          if (current is FavoritedState) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                      ),
                    ],
                  ),
                  CustomStarRate(rating: widget.restaurant.rating, size: 20),
                  const SizedBox(height: 5),
                  Text(
                    widget.restaurant.address,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
