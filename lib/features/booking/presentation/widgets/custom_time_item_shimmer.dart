import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomTimeItemShimmer extends StatelessWidget {
  const CustomTimeItemShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      margin: EdgeInsets.only(left: 15, top: 10),
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffF0EFEF),
            offset: Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 18,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
