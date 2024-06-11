import 'package:flutter/material.dart';
import 'scroll_configuration_drag_mouse.dart';

class SingleChildScrollViewScrollDrag extends StatelessWidget {
  final Widget child;
  final Axis scrollDirection;
  final _controller = ScrollController();

  SingleChildScrollViewScrollDrag(
      {required this.child, super.key, this.scrollDirection = Axis.vertical});

  @override
  Widget build(BuildContext context) => Scrollbar(
      thumbVisibility: false,
      controller: _controller,
      child: ScrollConfiguration(
          behavior: ScrollConfigurationDragMouse(),
          child: SingleChildScrollView(
            controller: _controller,
            scrollDirection: scrollDirection,
            child: child,
          )));
}
