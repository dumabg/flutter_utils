## 3.1.3

- Upgrade to Dart 3

## 3.1.2
- AsyncState: asyncInitState is called inside initState and the Future is completed with a Completer.

## 3.1.1
- Renamed `FormValidation` to `GlobalKeyFormStateValidation` and moved to extensions directory.

## 3.1.0
- Added `FormValidation` extension for `GlobalKey<FormState>` with the method `validateAndShowInvalid()`.

## 3.0.0
- `MockFactory` changed:
    -  Passing constructor parameters for instantiate a class with constructor parameters.
    - Define global variable mock for accessing mocks.