import 'dart:async';

import 'package:flutter/widgets.dart';

import 'async_state.dart';

/// Defines an interface indicating that an object has the dispose method.
abstract class Disposable {
  Future<void> dispose();
}

/// Define an [AsyncState] that will create a future [Disposable] controller.
/// When the object is disposed, it checks if the controller is created. In
/// this case, it calls [dispose] like an unawaited future.
/// The controller could be used by child objects via [controller] property.
/// This controller could be mocked by [MockFactory].
abstract class AsyncStateWithControllerDisposable<T extends StatefulWidget,
    U extends Disposable> extends AsyncStateWithController<T, U> {
  @override
  void dispose() {
    if (isControllerCreated()) {
      unawaited(controller.dispose());
    }
    super.dispose();
  }
}
