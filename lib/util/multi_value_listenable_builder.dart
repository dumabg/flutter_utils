import 'package:flutter/widgets.dart';

class MultiValueListenableBuilder extends StatelessWidget {
  final List<ValueNotifier> notifiers;
  final Widget? child;
  final Widget Function(BuildContext, Widget?) builder;
  final ValueNotifier<bool> mustRebuildSignal;

  MultiValueListenableBuilder(
      {Key? key, required this.notifiers, required this.builder, this.child})
      : mustRebuildSignal = ValueNotifier<bool>(true),
        super(key: key) {
    for (ValueNotifier notifier in notifiers) {
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
