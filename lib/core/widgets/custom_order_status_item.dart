import 'package:flutter/material.dart';

import '../utils/enum.dart';

class CustomOrderStatusItem extends StatelessWidget {
  const CustomOrderStatusItem({super.key, required this.status});
  final OrderStatus status;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color:
            status == OrderStatus.pending
                ? Color(0xffFCF6EA)
                : (status == OrderStatus.complated
                    ? Color(0xffECFAED)
                    : Color(0xffFCEAEA)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status == OrderStatus.pending
            ? 'Active'
            : (status == OrderStatus.complated ? 'Complated' : 'Cancelled'),
        style: TextStyle(
          color:
              status == OrderStatus.pending
                  ? Color(0xffEAB52D)
                  : (status == OrderStatus.complated
                      ? Color(0xff44CF51)
                      : Color(0xffF14545)),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
