import 'package:flutter/widgets.dart';

class ValueNotifierNotifier<T> extends ValueNotifier<T> {
  ValueNotifierNotifier(T value) : super(value);

  void notify() {
    super.notifyListeners();
  }
}
