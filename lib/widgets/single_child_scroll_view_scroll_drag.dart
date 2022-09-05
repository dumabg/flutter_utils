import 'package:flutter/material.dart';
import 'scroll_configuration_drag_mouse.dart';

class SingleChildScrollViewScrollDrag extends StatelessWidget {
  final Widget child;
  final Axis scrollDirection;
  final _controller = ScrollController();

  SingleChildScrollViewScrollDrag(
      {Key? key, required this.child, this.scrollDirection = Axis.vertical})
      : super(key: key);

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
