import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageItemShimmer extends StatelessWidget {
  const CustomImageItemShimmer({
    super.key,
    this.height = 100,
    this.width = 100,
  });
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
