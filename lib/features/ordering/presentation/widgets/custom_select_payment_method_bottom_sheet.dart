import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_managment_mobile/core/utils/enum.dart';
import 'package:restaurant_managment_mobile/features/ordering/presentation/bloc/pass_data/pass_data_bloc.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import 'custom_payment_method_item.dart';

void customSelectPaymentMethodBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (context) {
      return Container(
        height: 380,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const CustomSeletecPaymentMethod(),
            const Spacer(),
            CustomAnimatedButton(
              text: 'Continue',
              onClick: () {
                context.read<PassDataBloc>().state.paymentMethod ??
                    context.read<PassDataBloc>().add(
                      PassDataEvent(paymentMethod: PaymentMethod.payPal),
                    );
                context.push('/review-summary-ordering');
                context.pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

class CustomSeletecPaymentMethod extends StatefulWidget {
  const CustomSeletecPaymentMethod({super.key});

  @override
  State<CustomSeletecPaymentMethod> createState() =>
      _CustomSeletecPaymentMethodState();
}

class _CustomSeletecPaymentMethodState
    extends State<CustomSeletecPaymentMethod> {
  late int selected;
  @override
  void initState() {
    selected = context.read<PassDataBloc>().state.paymentMethod?.index ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        ...List.generate(
          4,
          (index) => CustomPaymentMethodItem(
            image: paymentMethodsImages[index],
            text: paymentMethodsTexts[index],
            index: index,
            indexRadio: selected,
            onChange: (value) {
              setState(() {
                selected = value!;
              });
              context.read<PassDataBloc>().add(
                PassDataEvent(paymentMethod: PaymentMethod.values[selected]),
              );
            },
          ),
        ),
      ],
    );
  }
}

const paymentMethodsImages = [
  'assets/images/payPal.png',
  'assets/images/googlePay.png',
  'assets/images/mastercard.png',
  'assets/images/onDelivery.png',
];
const paymentMethodsTexts = ['PayPal', 'Google Pay', 'Master Cart', 'Cash'];
