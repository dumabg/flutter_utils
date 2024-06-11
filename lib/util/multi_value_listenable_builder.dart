import 'package:flutter/widgets.dart';

class MultiValueListenableBuilder extends StatelessWidget {
  final List<ValueNotifier<dynamic>> notifiers;
  final Widget? child;
  final Widget Function(BuildContext, Widget?) builder;
  final ValueNotifier<bool> mustRebuildSignal;

  MultiValueListenableBuilder(
      {required this.notifiers, required this.builder, super.key, this.child})
      : mustRebuildSignal = ValueNotifier<bool>(true) {
    for (final ValueNotifier<dynamic> notifier in notifiers) {
      notifier.addListener(
          () => mustRebuildSignal.value = !mustRebuildSignal.value);
    }
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
      valueListenable: mustRebuildSignal,
      child: child,
      builder: (BuildContext context, bool value, Widget? child) =>
          builder(context, child));
}
