import 'package:flutter/material.dart';

class CustomGridSelectedItems extends StatefulWidget {
  const CustomGridSelectedItems({super.key, required this.child});
  final Widget Function(bool selected, int index) child;
  @override
  State<CustomGridSelectedItems> createState() =>
      _CustomGridSelectedItemsState();
}

class _CustomGridSelectedItemsState extends State<CustomGridSelectedItems> {
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        childAspectRatio: .9,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedItem = index;
            });
          },
          child: widget.child(_selectedItem == index, index),
        );
      },
    );
  }
}
