import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_managment_mobile/core/extensions/validator_extension.dart';
import '../../../../core/services/di/service_locator.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../auth/presentation/widgets/auth_text_form_field.dart';
import '../../data/models/delivery_address/delivery_info.dart';
import '../bloc/delivery_address/delivery_address_bloc.dart';

Future<dynamic> customAddAddressBottomSheet(
  BuildContext context, {
  DeliveryInfo? deliveryAddress,
}) {
  GlobalKey<FormState> formStateKey = GlobalKey();
  String? address;
  String? phone;
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    enableDrag: true,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        minChildSize: .4,
        initialChildSize: .4,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: formStateKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 3),
                    CustomTextField(
                      lines: 2,
                      text: 'Enter Address',
                      onSave: (value) {
                        address = value;
                      },
                      initialValue: deliveryAddress?.address,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 3),
                    AuthTextFormField(
                      hint: 'Enter Phone Number',
                      preIcon: Icons.phone,
                      onSave: (value) {
                        phone = value;
                      },
                      initailValue: deliveryAddress?.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value?.replaceAll(' ', '').isEmpty ?? true) {
                          return "phone can't be empty";
                        } else if (!value!.isPhoneValid) {
                          return 'invalid phone number';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomAnimatedButton(
                      text: 'Add',
                      onClick: () {
                        if (formStateKey.currentState?.validate() ?? false) {
                          formStateKey.currentState?.save();
                          if (deliveryAddress == null) {
                            getIt<DeliveryAddressBloc>().add(
                              AddDeliveryAddressEvent(
                                DeliveryInfo(address: address!, phone: phone!),
                              ),
                            );
                          } else {
                            getIt<DeliveryAddressBloc>().add(
                              EditDeliveryAddressEvent(
                                deliveryAddress.copyWith(
                                  address: address,
                                  phone: phone,
                                ),
                                deliveryAddress.id,
                              ),
                            );
                          }

                          context.pop();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
