import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_managment_mobile/features/ordering/presentation/widgets/custom_add_address_bottom_sheet.dart';
import '../../../../core/constants/colors.dart';
import '../../data/models/delivery_address/delivery_info.dart';
import '../bloc/delivery_address/delivery_address_bloc.dart';

class CustomDeliveryAddressItem extends StatelessWidget {
  const CustomDeliveryAddressItem({
    super.key,
    required this.selected,
    required this.deliverAddress,
  });
  final bool selected;
  final DeliveryInfo deliverAddress;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: selected ? primary.withAlpha(15) : const Color(0xffF0F0F0),
        border: Border.all(
          color: selected ? primary : Colors.white,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: primary,
                child: Icon(Icons.location_on, color: Colors.white),
              ),

              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 260,
                    child: Text(
                      deliverAddress.address,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Phone No : ${deliverAddress.phone}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
                child: PopupMenuButton(
                  color: Colors.white,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        height: 0,
                        padding: EdgeInsets.only(bottom: 5, left: 10, top: 5),
                        onTap: () {
                          customAddAddressBottomSheet(
                            context,
                            deliveryAddress: deliverAddress,
                          );
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            color: Color(0xff1AF021),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        height: 0,
                        padding: EdgeInsets.only(bottom: 5, left: 10, top: 5),
                        onTap: () {
                          context.read<DeliveryAddressBloc>().add(
                            DeleteDeliveryAddressEvent(deliverAddress.id),
                          );
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
