import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomOrderItemShimmer extends StatelessWidget {
  const CustomOrderItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 183,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 3),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
        child: Column(
          spacing: 5,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 14,
                  children: [
                    container(16, 50),
                    container(16, 30),
                    container(16, 60),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [container(16, 60), container(16, 50)],
                  ),
                  const SizedBox(height: 20),
                  container(16, 170),
                  const SizedBox(height: 5),
                  container(16, 170),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container container(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
