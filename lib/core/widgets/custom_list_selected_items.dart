import 'package:flutter/material.dart';

class CustomListSelectedItems<T> extends StatefulWidget {
  const CustomListSelectedItems({
    super.key,
    required this.child,
    required this.height,
    this.items = const [],
    this.onTap,
  });
  final Widget Function(bool selected, T) child;
  final List<T> items;
  final double height;
  final void Function(T t)? onTap;
  @override
  State<CustomListSelectedItems<T>> createState() =>
      _CustomListSelectedItemsState<T>();
}

class _CustomListSelectedItemsState<T>
    extends State<CustomListSelectedItems<T>> {
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
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
        },
      ),
    );
  }
}
