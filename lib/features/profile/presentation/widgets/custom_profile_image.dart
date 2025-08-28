import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_managment_mobile/features/profile/presentation/widgets/custom_image_item_shimmer.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({super.key, this.image, required this.onTap});
  final String? image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(500),
          child:
              image == null
                  ? Image.asset(
                    'assets/images/defualtProfile.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                  : CachedNetworkImage(
                    imageUrl: image!,
                    errorWidget:
                        (context, url, error) => Image.asset(
                          'assets/images/defualtProfile.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                    placeholder: (context, url) => CustomImageItemShimmer(),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
        ),
        Positioned(
          bottom: 0,
          right: -5,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(500),
            ),
            child: InkWell(
              onTap: onTap,
              child: SvgPicture.asset('assets/icons/edit3.svg'),
            ),
          ),
        ),
      ],
    );
  }
}
