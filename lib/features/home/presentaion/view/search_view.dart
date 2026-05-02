import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_error_page.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../bloc/search/search_bloc.dart';
import '../widgets/custom_no_search_item.dart';
import '../widgets/custom_search_item.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String text = '';
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 35,
        titleSpacing: 0,
        leading: SizedBox(
          width: 35,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios, size: 25),
          ),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomTextFormField(
            text: 'Search Restaurant',
            onSubmit: (value) {
              if (value.replaceAll(' ', '').isNotEmpty) {
                context.read<SearchBloc>().add(
                  FetchRestaurantsSearchEvent(value),
                );
              }
            },
            onChange: (value) {
              setState(() {
                text = value;
              });
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is LoadingSearchState) {
              return const Column(
                children: [
                  Spacer(flex: 3),
                  Center(child: CircularProgressIndicator()),
                  Spacer(flex: 4),
                ],
              );
            } else if (state is FetchedRestaurantsSearchState) {
              if (state.restaurants.isEmpty) {
                return const CustomNoSearchItem();
              } else {
                return ListView.builder(
                  itemCount: state.restaurants.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder:
                      (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CustomSearchItem(
                          restaurant: state.restaurants[index],
                        ),
                      ),
                );
              }
            } else if (state is FailedSearchState) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: CustomErrorPage(
                  onRetry: () {
                    if (text.replaceAll(' ', '').isNotEmpty) {
                      context.read<SearchBloc>().add(
                        FetchRestaurantsSearchEvent(text),
                      );
                    }
                  },
                  height: 150,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
