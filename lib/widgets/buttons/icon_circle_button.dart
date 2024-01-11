import 'package:flutter/material.dart';
import 'circle_button.dart';

class IconCircleButton extends CircleButton {
  IconCircleButton(
      {super.key,
      required IconData iconData,
      super.color,
      super.onPressed,
      Color iconColor = Colors.white,
      double? size,
      super.borderSide})
      : super(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              iconData,
              color: iconColor,
              size: size,
            ),
          ),
        );
}
