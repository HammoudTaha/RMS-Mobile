import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class CustomAnimatedButton extends StatefulWidget {
  const CustomAnimatedButton({
    super.key,
    required this.text,
    required this.onClick,
    this.visable = true,
  });
  final String text;
  final void Function() onClick;
  final bool visable;
  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scale;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    controller.reverse();
    scale = Tween<double>(begin: 1, end: .95).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.visable
        ? GestureDetector(
          onTapDown: (details) {
            controller.forward();
          },
          onTapUp: (details) {
            widget.onClick();
            controller.reverse();
          },
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform.scale(scale: scale.value, child: child);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )
        : Container(
          height: 50,
          decoration: BoxDecoration(
            color: primary.withAlpha(150),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
  }
}
