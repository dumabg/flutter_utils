import 'package:flutter/material.dart';

class CircleButton extends ElevatedButton {
  CircleButton(
      {Key? key,
      Widget? child,
      Color? color,
      VoidCallback? onPressed,
      BorderSide borderSide = BorderSide.none})
      : super(
            key: key,
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                elevation: 2.0,
                backgroundColor: color,
                shape: CircleBorder(side: borderSide)),
            child: child);
}
