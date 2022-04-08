import 'package:form_field_validator/form_field_validator.dart';

class RequiredTValidator<T> extends FieldValidator<T?> {
  RequiredTValidator({required String errorText}) : super(errorText);

  @override
  bool isValid(T? value) {
    return value != null;
  }
}
