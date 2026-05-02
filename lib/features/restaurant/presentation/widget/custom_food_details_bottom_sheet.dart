import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/custom_snakbar.dart';
import '../../../../core/widgets/custom_outline_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../cart/data/models/cart/cart.dart';
import '../../../cart/presentation/bloc/cart/cart_bloc.dart';
import '../../data/models/menu/menu.dart';

Future<dynamic> customFoodDetailsBottomSheet(
  BuildContext context, {
  required Menu menu,
}) {
  String? text;
  final GlobalKey<FormState> formStateKey = GlobalKey();
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return BlocProvider(
        create: (context) => CartBloc(),
        child: Builder(
          builder: (context) {
            return DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return Scaffold(
                  body: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(50),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                      child: Image.asset(
                                        'assets/images/C.png',
                                        fit: BoxFit.cover,
                                        height: 250,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: Form(
                                        key: formStateKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  menu.name,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '\$ ${menu.price}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: primary,
                                                  ),
                                                ),
                                                Row(
                                                  spacing: 5,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      size: 20,
                                                      color: primary,
                                                    ),
                                                    Text(
                                                      '${menu.estimationTime} minutes',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              'Description ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              menu.description,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              'Dietary Info',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '– ${menu.dietaryInfo['vegetarian'] ? 'Vegetarian' : 'Not vegetarian'}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '– ${menu.dietaryInfo['vegan'] ? 'Contains vegan' : 'Contains no vegan'}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '– ${menu.dietaryInfo['gluten_free'] ? 'Gluten-free diet' : 'Contains gluten'}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '– ${menu.dietaryInfo['gluten_free'] ? 'Contains dairy' : 'Contains no dairy'}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '– ${menu.dietaryInfo['spicy'] ? 'Spicy' : 'Not spicy'}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              'Special Requests',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            CustomTextField(
                                              lines: 4,
                                              text:
                                                  'Describe Your Special Requests',
                                              onSave: (value) {
                                                text = value;
                                              },
                                            ),
                                            const SizedBox(height: 250),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: SizedBox(
                          height: 50,
                          child: BlocListener<CartBloc, CartState>(
                            listener: (context, state) {
                              if (state is ExistedCartState) {
                                if (state.isExist) {
                                  showSnakbar(
                                    'Food already has been added to Shopping Cart',
                                  );
                                } else {
                                  context.read<CartBloc>().add(
                                    AddCartEvent(
                                      Cart(
                                        menu: menu,
                                        note:
                                            text
                                                        ?.replaceAll(' ', '')
                                                        .isNotEmpty ??
                                                    false
                                                ? text
                                                : null,
                                      ),
                                    ),
                                  );

                                  showSnakbar(
                                    'Product has been added to Shopping Cart',
                                  );
                                }
                              } else if (state is FailedCartState) {
                                showSnakbar(state.message);
                              }
                            },
                            child: CustomOutLineButton(
                              text: 'Add To Cart',
                              onTap: () {
                                context.read<CartBloc>().add(
                                  IsExistCartEvent(menu),
                                );
                                formStateKey.currentState?.save();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
    },
  );
}
