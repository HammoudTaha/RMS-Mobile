import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_error_page.dart';
import '../bloc/delivery_address/delivery_address_bloc.dart';
import '../widgets/custom_empty_delivery_address.dart';
import '../widgets/custom_fab.dart';
import '../widgets/custom_full_delivery_address.dart';

class SelectAddressView extends StatelessWidget {
  const SelectAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Select delivery Address',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        child: BlocBuilder<DeliveryAddressBloc, DeliveryAddressState>(
          builder: (context, state) {
            if (state is FetchedDeliveryAddressesState) {
              if (state.deliveryAddresses.isEmpty) {
                return CustomEmptyDeliveryAddress();
              }
              return CustomFullDeliveryAddress(
                deliveryAddresses: state.deliveryAddresses,
              );
            } else if (state is FailedDeliveryAddressState) {
              return CustomErrorPage(onRetry: () {});
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: CustomFAB(),
    );
  }
}
