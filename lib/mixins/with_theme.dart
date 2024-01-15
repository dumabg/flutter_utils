import 'package:flutter/material.dart';

mixin WithTheme<T> {
  T themeOf(BuildContext context) {
    return Theme.of(context).extension<T>()!;
  }
}
