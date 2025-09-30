import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_utils/util/navigator_of.dart';
import 'package:flutter_utils/widgets/loading_indicator.dart';

extension FutureLoadingIndicator<T> on Future<T> {
  Future<T> withLoadingIndicator() async {
    final BuildContext context = NavigatorOf.navigatorKey.currentState!.context;
    await showDialog<void>(
      context: context,
      builder: (context) => const LoadingIndicator(),
    );
    await whenComplete(() {
      Navigator.pop(context);
    });
    return this;
  }
}
