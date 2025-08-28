import 'package:flutter/material.dart';

class CustomWrapSelectedItems<T> extends StatefulWidget {
  const CustomWrapSelectedItems({
    super.key,
    required this.child,
    this.spacing = 10,
    this.runSpacing = 10,
    this.items = const [],
    this.onTap,
    this.initial = 0,
  });
  final double spacing;
  final double runSpacing;
  final Widget Function(bool, T) child;
  final List<T> items;
  final void Function(T t)? onTap;
  final int initial;
  @override
  State<CustomWrapSelectedItems<T>> createState() =>
      _CustomWrapSelectedItemsState<T>();
}

class _CustomWrapSelectedItemsState<T>
    extends State<CustomWrapSelectedItems<T>> {
  late int _selectedItem;
  @override
  void initState() {
    _selectedItem = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: List.generate(widget.items.length, (index) {
        return GestureDetector(
          onTap: () {
            if (widget.onTap != null && _selectedItem != index) {
              widget.onTap!(widget.items[index]);
            }
            setState(() {
              _selectedItem = index;
            });
          },
          child: widget.child(_selectedItem == index, widget.items[index]),
        );
      }),
    );
  }
}
