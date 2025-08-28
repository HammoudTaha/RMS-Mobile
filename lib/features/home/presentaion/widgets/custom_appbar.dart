import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/public/bloc/translate/translate_bloc.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 20),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "hello_name".tr(namedArgs: {'name': "Hammoud"}),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    spacing: 5,
                    children: [
                      const Icon(Icons.location_on_rounded, color: Colors.red),
                      Text(
                        "user_location".tr(
                          namedArgs: {'location': "Damascus, Syria"},
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              CustomAppbarActionItem(
                icon: Icons.shopping_cart,
                onTap: () {
                  context.push('/cart');
                },
              ),
              const SizedBox(width: 10),
              CustomAppbarActionItem(
                icon: Icons.notifications,
                onTap: () {
                  if (context.locale.toString() == 'en') {
                    context.read<TranslateBloc>().add(ArabicTranslateEvent());
                  } else {
                    context.read<TranslateBloc>().add(EnglishTranslateEvent());
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              context.push('/search');
            },
            child: Container(
              height: 40,
              width: 300,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/nav_search.svg',
                    colorFilter: ColorFilter.linearToSrgbGamma(),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'search_label'.tr(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppbarActionItem extends StatelessWidget {
  const CustomAppbarActionItem({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final void Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
//  () {
//         if (context.locale.toString() == 'en') {
//           context.read<TranslateBloc>().add(ArabicTranslateEvent());
//         } else {
//           context.read<TranslateBloc>().add(EnglishTranslateEvent());
//         }
//       }