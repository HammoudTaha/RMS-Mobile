import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_delivery_address_text.dart';
import '../bloc/pass_data/pass_data_bloc.dart';

class CustomOrderDeliveryInfoItem extends StatelessWidget {
  const CustomOrderDeliveryInfoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            children: [
              Expanded(child: Divider(color: Colors.black26, endIndent: 10)),
              const Text(
                'Delivery Info  ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Expanded(child: Divider(color: Colors.black26)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffF0EFEF),
                  offset: Offset(0, 0),
                  blurRadius: 6,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              spacing: 10,
              children: [
                CustomDeliveryAddressText(
                  text1: 'Delivery Address : ',
                  text2:
                      context
                          .read<PassDataBloc>()
                          .state
                          .deliveryInfo
                          ?.address ??
                      'No Address',
                ),
                CustomDeliveryAddressText(
                  text1: 'Phone : ',
                  text2:
                      context.read<PassDataBloc>().state.deliveryInfo?.phone ??
                      'No Phone',
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
