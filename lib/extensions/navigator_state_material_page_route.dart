import 'package:flutter/material.dart';

extension NavigatorStateMaterialPageRoute on NavigatorState {
  Future<T?> pushMaterialPageRoute<T extends Object?>(
          Widget Function(BuildContext context) builder) =>
      push<T>(MaterialPageRoute(builder: builder));

  Future<T?>
      pushReplacementMaterialPageRoute<T extends Object?, TO extends Object?>(
              Widget Function(BuildContext context) builder) =>
          pushReplacement<T, TO>(MaterialPageRoute(builder: builder));
}
