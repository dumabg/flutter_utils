import 'package:flutter_utils/widgets/async_state.dart';

/// When a class would be needed to mock, it can create a factory that uses
/// [mock] for return a mocked instance (if is mocked) or create a normal object.
///
/// Create a factory and a named constructor. For exemple:
///
/// ```dart
/// class GoogleLogin {
///
///   factory GoogleLogin() {
///     return mock?.of<GoogleLogin>() ?? GoogleLogin.$();
///   }
///   @protected
///   GoogleLogin.$();
///
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
///
/// If your class constructor needs parameters, pass it like a Map. For exemple:
/// ```dart
/// factory FirebaseImage(String location,
///       {double scale = 1.0, int cacheVersion = 0, Uint8List? emptyImage}) {
///     return mock?.of<FirebaseImage>(<String, dynamic>{
///           'location': location,
///           'scale': scale,
///           'cacheVersion': cacheVersion,
///           'emptyImage': emptyImage,
///         }) ??
///         FirebaseImage.$(location, scale, cacheVersion, emptyImage);
///   }
///   @protected
///   FirebaseImage.$(
///       this.location, this.scale, this.cacheVersion, this.emptyImage);
/// ```
/// Put your named constructor protected if you want to extends the class for creating the mock class.
///
/// When create your mock, you can access the parameters and create the object correctly. For exemple:
/// ```dart
/// class FirebaseImageMock extends FirebaseImage implements Mock {
///  FirebaseImageMock(String location) : super.$(location, 1.0, 0, null);
///
///   static void use() {
///     mock!.register<FirebaseImage>((Map<String, dynamic>? params) =>
///         FirebaseImageMock(params!['location'] as String));
///   }
/// ```
MockFactory? mock;

/// Class used for register and obtain mocking objects.
///
/// See global variable [mock]
class MockFactory {
  final Map<Type, dynamic Function(Map<String, dynamic>? params)> _callbacks =
      {};
  final Map<Type, _AsyncFactoryMock<dynamic>> _callbacksAsyncFactory = {};

  /// Returns a new instance of a mocked object of type T if it is registered, else null.
  T? of<T>([Map<String, dynamic>? params]) {
    dynamic value;
    // T is AsyncFactory always return false, because "is" operator will check
    // if left operand is an instance of right operand. T is an instance of Type,
    // not an AsyncFactory.
    //
    // T == AsyncFactory always return false, because == checks for identity
    // and will not support subtypes.
    //
    // To support type inheritance you can use a trick like this: <T>[] is List<AsyncFactory>
    if (<T>[] is List<AsyncFactory>) {
      final _AsyncFactoryMock<dynamic>? mock = _callbacksAsyncFactory[T];
      mock?.params = params;
      value = mock;
    } else {
      value = _callbacks[T]?.call(params);
    }
    return value == null ? null : value as T;
  }

  /// Register a function for creating a mocked object of type T.
  /// ```dart
  /// mock!.register<ExperienceDetailController>(
  ///    (params) => ExperienceDetailControllerMock());
  /// ```
  void register<T>(T Function(Map<String, dynamic>? params) f) {
    _callbacks[T] = f;
  }

  /// Register a function for creating a mocked object of type T,
  /// created from AsyncFactory.
  /// The mock is created when request an AsyncFactory<T> type.
  ///
  /// ```dart
  /// mock!.registerAsyncFactoryFor<ExperienceDetailController>(
  ///    (params) => ExperienceDetailControllerMock());
  /// ```
  void registerAsyncFactoryFor<T>(T Function(Map<String, dynamic>? params) f) {
    _callbacksAsyncFactory[AsyncFactory<T>] = _AsyncFactoryMock<T>(f);
  }
}

/// The AsyncFactoryMock for a type
class _AsyncFactoryMock<T> extends AsyncFactory<T> {
  Map<String, dynamic>? params;
  final T Function(Map<String, dynamic>? params) f;

  _AsyncFactoryMock(this.f);

  @override
  Future<T> instance() async => f.call(params);
}
