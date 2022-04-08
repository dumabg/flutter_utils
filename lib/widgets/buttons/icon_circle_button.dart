import 'package:flutter/material.dart';
import 'circle_button.dart';

class IconCircleButton extends CircleButton {
  IconCircleButton(
      {Key? key,
      required IconData iconData,
      Color? color,
      VoidCallback? onPressed,
      Color iconColor = Colors.white,
      double? size,
      BorderSide borderSide = BorderSide.none})
      : super(
          key: key,
          onPressed: onPressed,
          color: color,
          borderSide: borderSide,
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
