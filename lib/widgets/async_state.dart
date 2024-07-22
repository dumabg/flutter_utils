import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_utils/mocking/mock_factory.dart';
import 'loading_indicator.dart';

/// Define a [StatefulWidget] [State] that will use an object with the
/// controller role.
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

  /// Creates the controller. If a mocked controller is registered in
  /// [MockFactory], it use the mocked controller else calls [createController]
  /// for creating it.
  void initState() {
    _controller = mock?.of<U>() ?? createController();
    super.initState();
  }
}

/// Define the [StatefulWidget] [State] like async. Build phase is done with a
/// FutureBuilder than calls the method asyncInitState for launch all Futures
/// needs for this State. In this phase the build is doing in the
/// buildWhenLoading method. By default, it shows a LoadingIndicator.
///
/// When asyncInitState is done, it examines the Future result. If all is ok,
/// the buildWhenDone is called.
///
/// If an error occurs, buildWhenError method is called.
/// By default, buildWhenError shows in the middle a red replay icon, that can
/// touch to retry.
abstract class AsyncState<T extends StatefulWidget> extends State<T> {
  bool _futureDone = false;

  /// Allows initialize the [State] with async calls.
  Future<void> asyncInitState();

  /// Build method when the [State] are initialized correctly with
  /// [asyncInitState]
  Widget buildWhenDone(BuildContext context);

  static void Function(Object error, StackTrace? stack)? onError;

  Completer<void>? _asyncInitStateCompleter;

  @override
  void initState() {
    _asyncInitState();
    super.initState();
  }

  void _asyncInitState() {
    _asyncInitStateCompleter = Completer<void>();
    unawaited(asyncInitState().then((_) => _asyncInitStateCompleter!.complete(),
        onError: (Object err, StackTrace? stack) =>
            _asyncInitStateCompleter!.completeError(err, stack)));
  }

  @override
  Widget build(BuildContext context) => _futureDone
      ? buildWhenDone(context)
      : FutureBuilder(
          future: _asyncInitStateCompleter?.future,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                _asyncInitStateCompleter = null;
                if (snapshot.hasError) {
                  _futureDone = false;
                  onError?.call(snapshot.error!, snapshot.stackTrace);
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

  /// Retry asyncInitState only if the previous call to asyncInitState is
  /// completed. This method is called after pressing retry button on default
  /// [buildWhenError].
  void retryAsyncInitState() {
    if (_asyncInitStateCompleter == null) {
      setState(_asyncInitState);
    }
  }

  /// Build method when [asyncInitState] ends with and error. It shows in
  /// the middle a red replay icon, that can touch to retry.
  Widget buildWhenError(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: IconButton(
            icon: const Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.replay,
                      color: Colors.white,
                      size: 42,
                    ),
                  )
                ]),
            onPressed: retryAsyncInitState),
      ),
    );
  }
}

/// [AsyncFactory.futureCancelable] function for wrapping
/// functions that return [Future] that must be supported for canceling.
typedef FutureCancelable = Future<U> Function<U>(Future<U> f);

class _CancelException {}

/// Base class for creating async controller factories.
/// To create an async controller factory, extends this class and overrides
/// [AsyncFactory.instance].
/// Inside instance, create the code for creating the controller.
/// It could have async calls, for exemple a call to the server.
/// Put these async calls wrapped with futureCancelable. This allows to stop
/// automatically the creation if cancel is activated.
///
/// {@tool snippet}
/// This sample shows an async controller factory.
/// It uses the method OrdersOpenApi().orders, that returns a Future.
/// See how the call is wrapped with futureCancelable and how it is passed to
/// orders.
/// Inside orders, the method ordersOpen returns a Future. So, again, is wrapped
/// with futureCancelable.
/// If, for example, the user is in a screen and this controller is awaiting in
/// ordersOpen and the user backs, the factory is cancelled. When ordersOpen
/// ends the Future, it doesn't execute the next line, ordersOpen.orders.map,
/// neither the line orders.sort inside instance.
///
/// ```dart
/// class OrdersOpenControllerFactory extends AsyncFactory<OrdersOpenController>
/// {
/// @override
///  Future<OrdersOpenController> instance() async {
///    final List<Order> orders =
///        await futureCancelable(OrdersOpenApi().orders(futureCancelable));
///    orders.sort((order1, order2) => order1.start.compareTo(order2.start));
///    return OrdersOpenController._(orders);
/// }
///
/// class OrdersOpenApi {
///  Future<List<Order>> orders(FutureCancelable futureCancelable) async {
///    final OrdersOpenRequest request = OrdersOpenRequest();
///    final OrdersOpenResponse ordersOpen =
///        await futureCancelable(Server.instance.ordersOpen(request));
///    final List<Order> result =
///        ordersOpen.orders.map<Order>((OrderOpenResponse apiOrder) {
///         ...
///
/// ```
/// {@end-tool}
abstract class AsyncFactory<T> {
  bool _isCanceled = false;

  /// True if must cancel the creation of the current async controller.
  bool get isCanceled => _isCanceled;

  /// Checks if the factory must cancel the creation of the current async
  /// controller. If true, it stops the creation.
  Future<U> futureCancelable<U>(Future<U> f) async {
    return f.then(
      (value) {
        if (_isCanceled) {
          throw _CancelException();
        } else {
          return value;
        }
      },
    );
  }

  Future<T?> _create() async {
    try {
      return await futureCancelable(instance());
    } on _CancelException {
      return null;
    }
  }

  /// Must return the future of controller.
  Future<T> instance();

  /// Mark like must cancel the creation of the current async controller.
  void cancel() {
    _isCanceled = true;
  }
}

/// Define an [AsyncState] that depends on async controller.
/// An [AsyncFactory] of the controller must be returned. It's used to create
/// the async controller.
/// If the widget is disposed before the controller is created,
/// [AsyncFactory.cancel] is called.
/// When the controller is created, could be used via [controller] property.
/// This controller could be mocked by [MockFactory].
abstract class AsyncStateWithController<T extends StatefulWidget, U>
    extends AsyncState<T> {
  U? _controller;
  U get controller => _controller!;
  AsyncFactory<U>? _factory;

  @protected
  AsyncFactory<U> controllerFactory();

  @override
  @mustCallSuper
  Future<void> asyncInitState() async {
    _factory = mock?.of<AsyncFactory<U>>() ?? controllerFactory();
    _controller = await _factory!._create();
    _factory = null;
  }

  /// Determine if the controller is created. CreateController method
  /// returns a Future so it's possible than the controller isn't created
  /// when calls another methods, like buildWhenLoading, buildWhenError,
  /// dispose, ...
  bool isControllerCreated() => _controller != null;

  @override
  void dispose() {
    _factory?.cancel();
    super.dispose();
  }
}
