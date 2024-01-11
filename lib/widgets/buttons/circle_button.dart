import 'package:flutter/material.dart';

class CircleButton extends ElevatedButton {
  CircleButton(
      {super.key,
      super.child,
      Color? color,
      super.onPressed,
      BorderSide borderSide = BorderSide.none})
      : super(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                elevation: 2.0,
                backgroundColor: color,
                shape: CircleBorder(side: borderSide)));
}
