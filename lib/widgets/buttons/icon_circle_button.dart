import 'package:flutter/material.dart';
import 'circle_button.dart';

class IconCircleButton extends CircleButton {
  IconCircleButton(
      {required IconData iconData,
      super.key,
      super.color,
      super.onPressed,
      Color iconColor = Colors.white,
      double? size,
      super.borderSide})
      : super(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              iconData,
              color: iconColor,
              size: size,
            ),
          ),
        );
}
