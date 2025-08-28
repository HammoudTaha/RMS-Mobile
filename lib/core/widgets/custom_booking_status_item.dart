import 'package:flutter/material.dart';

import '../utils/enum.dart';

class CustomBookingStatusItem extends StatelessWidget {
  const CustomBookingStatusItem({super.key, required this.status});
  final BookStatus status;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color:
            status == BookStatus.active
                ? Color(0xffFCF6EA)
                : (status == BookStatus.complated
                    ? Color(0xffECFAED)
                    : Color(0xffFCEAEA)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status == BookStatus.active
            ? 'Active'
            : (status == BookStatus.complated ? 'Complated' : 'Cancelled'),
        style: TextStyle(
          color:
              status == BookStatus.active
                  ? Color(0xffEAB52D)
                  : (status == BookStatus.complated
                      ? Color(0xff44CF51)
                      : Color(0xffF14545)),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
