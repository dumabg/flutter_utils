import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_utils/mocking/mock_factory.dart';
import 'loading_indicator.dart';

/// Define a [StatefulWidget] [State] that will use an object with the controller role.
/// The controller could be used by child objects via [controller] property.
/// This controller could be mocked by [MockFactory].

abstract class StateWithController<T extends StatefulWidget, U>
    extends State<T> {
  U? _controller;
  U get controller => _controller!;

  /// Return the the controller.
  U createController();

  @override
  @mustCallSuper

  /// Creates the controller. If a mocked controller is registered in [MockFactory],
  /// it use the mocked controller else calls [createController] for creating it.
  void initState() {
    _controller = mock?.of<U>() ?? createController();
    super.initState();
  }
}

/// Define the [StatefulWidget] [State] like async. Build phase is done with a FutureBuilder
/// than calls the method asyncInitState for launch all Futures needs for this State.
/// In this phase the build is doing in the buildWhenLoading method. By default,
/// it shows a LoadingIndicator.
///
/// When asyncInitState is done, it examines the Future result. If all is ok,
/// the buildWhenDone is called.
///
/// If an error occurs, the error is passed to ToastService
/// and the buildWhenError method is called. By default, buildWhenError shows in
/// the middle a red replay icon, that can touch to retry.
abstract class AsyncState<T extends StatefulWidget> extends State<T> {
  bool _futureDone = false;

  /// Allows initialize the [State] with async calls.
  Future<void> asyncInitState();

  /// Build method when the [State] are initialized correctly with [asyncInitState]
  Widget buildWhenDone(BuildContext context);

  static Function(Object error)? onError;

  Completer<void>? _asyncInitStateCompleter;

  @override
  void initState() {
    _asyncInitStateCompleter = Completer<void>();
    asyncInitState().then((_) => _asyncInitStateCompleter!.complete());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _futureDone
      ? buildWhenDone(context)
      : FutureBuilder(
          future: _asyncInitStateCompleter?.future,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError) {
                  _futureDone = false;
                  onError?.call(snapshot.error!);
                  return buildWhenError(context);
                } else {
                  _futureDone = true;
                  return buildWhenDone(context);
                }
              default:
                return buildWhenLoading(context);
            }
          });

  /// Build method when are waiting for the end of [asyncInitState].
  Widget buildWhenLoading(BuildContext context) => const LoadingIndicator();

  /// Build method when [asyncInitState] ends with and error. It shows in
  /// the middle a red replay icon, that can touch to retry.
  Widget buildWhenError(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
              icon: Stack(children: [
                Container(),
                const Positioned(
                  left: 8,
                  top: 3,
                  child: Icon(
                    Icons.replay,
                    color: Colors.blueAccent,
                  ),
                ),
                const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 15,
                )
              ]),
              // ignore: no-empty-block
              onPressed: () => {setState(() {})})),
    );
  }
}

/// Defines an async controller.
abstract class AsyncController {
  /// Initialization of the async controller.
  Future<void> asyncInitState();
}

/// Define an [AsyncState] that will use an [AsyncController].
/// The controller could be used by child objects via [controller] property.
/// This controller could be mocked by [MockFactory].

abstract class AsyncStateWithController<T extends StatefulWidget,
    U extends AsyncController> extends AsyncState<T> {
  U? _controller;
  U get controller => _controller!;

  U createController();

  @override
  @mustCallSuper
  Future<void> asyncInitState() async {
    _controller = mock?.of<U>() ?? createController();
    await controller.asyncInitState();
  }
}
