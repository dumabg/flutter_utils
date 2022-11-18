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
  final Map<Type, dynamic Function(Map<String, dynamic>? params)?> _callbacks =
      {};

  /// Returns a new instance of a mocked object of type T if it is registered, else null.
  T? of<T>([Map<String, dynamic>? params]) {
    dynamic value = _callbacks[T]?.call(params);
    return value == null ? null : value as T;
  }

  /// Register a function for creating a mocked object of type T.
  /// ```dart
  /// mock!.register<ExperienceDetailController>(
  ///    (params) => ExperienceDetailControllerMock());
  /// ```
  void register<T>(T Function(Map<String, dynamic>? params)? f) {
    _callbacks[T] = f;
  }
}
