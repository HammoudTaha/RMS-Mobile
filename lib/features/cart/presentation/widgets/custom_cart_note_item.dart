import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_managment_mobile/core/utils/custom_confirm_dialog.dart';
import '../../../../core/utils/custom_dialog.dart';
import '../../../../core/widgets/custom_outline_button.dart';
import '../../data/models/cart/cart.dart';
import '../bloc/cart/cart_bloc.dart';

class CustomNoteCartItem extends StatefulWidget {
  const CustomNoteCartItem({super.key, required this.cart});
  final Cart cart;

  @override
  State<CustomNoteCartItem> createState() => _CustomNoteCartItemState();
}

class _CustomNoteCartItemState extends State<CustomNoteCartItem> {
  String? _note;
  @override
  Widget build(BuildContext context) {
    return widget.cart.note != null
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 5,
          children: [
            SizedBox(
              width: 350,
              child: Text.rich(
                TextSpan(
                  text: 'Note : ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                      text: widget.cart.note!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: CustomOutLineButton(
                    text: 'Cancel Note',
                    onTap: () {
                      customConfirmDialog(
                        context,
                        title: 'Cancel Note',
                        message: 'Are you sure to cancel this note',
                        onPressed: () {
                          context.read<CartBloc>().add(
                            CancelNoteCartEvent(widget.cart.menu.id),
                          );
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: CustomOutLineButton(
                    text: 'Edit Note',
                    onTap: () {
                      customAlertDialog(
                        context,
                        onSave: (value) {
                          _note = value;
                        },
                        initalValue: widget.cart.note,
                        text: 'Edit Your Note',
                        onPressed: () {
                          context.read<CartBloc>().add(
                            AddNoteCartEvent(
                              id: widget.cart.menu.id,
                              note: _note!,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        )
        : CustomOutLineButton(
          text: 'Add Note',
          onTap: () {
            customAlertDialog(
              context,
              text: 'Add Note',
              onSave: (value) {
                _note = value;
              },
              initalValue: widget.cart.note,
              onPressed: () {
                context.read<CartBloc>().add(
                  AddNoteCartEvent(id: widget.cart.menu.id, note: _note!),
                );
              },
            );
          },
        );
  }
}
