import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final int value;
  final Color color;
  final double size;

  const Stars(
      {required this.value, required this.color, super.key, this.size = 30.0});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (i) {
          return Icon(
            i <= value - 1 ? Icons.star : Icons.star_border,
            size: size,
            color: color,
          );
        }));
  }
}
