/// Class used for mock objects.
/// When a class would be needed to mock for testing, it can create a factory that uses
/// [MockFactory] for return a mocked instance (if is mocked) or create a normal object.
///
/// For exemple:
/// ```dart
/// class GoogleLogin {
///   GoogleLogin._();
///
///   factory GoogleLogin() {
///     return MockFactory.instance<GoogleLogin>() ?? GoogleLogin._();
///   }
///   ...
/// }
/// ```
///
/// The class is used normally:
/// ```dart
/// Future<void> logInWithGoogle() async {
///   UserCredential? userCredential = await GoogleLogin().login();
///   ...
/// }
/// ```

class MockFactory {
  static final Map<Type, dynamic Function()?> _callbacks = {};

  /// Returns the mocked object of type T if it is registered, otherwise null.
  static T? instance<T>() {
    if (_callbacks.isEmpty) {
      return null;
    } else {
      dynamic value = _callbacks[T]?.call();
      return value == null ? null : value as T;
    }
  }

  /// Register a function for creating a mocked object of type T.
  static void register<T>(T Function()? f) {
    _callbacks[T] = f;
  }
}
