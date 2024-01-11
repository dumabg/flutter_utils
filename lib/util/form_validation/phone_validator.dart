import 'package:form_field_validator/form_field_validator.dart';
import 'package:dart_utils/extensions/string/remove_chars.dart';

class PhoneValidator extends TextFieldValidator {
  String _countryCode = "";
  set countryCode(String value) {
    _countryCode = "+$value";
  }

  final RegExp _regExp;

  PhoneValidator(super.errorText)
      : _regExp = RegExp(r"^\+(?:[0-9] ?){6,14}[0-9]$");

  //Required pattern for Pagar.me: ^\\+(?:[0-9] ?){6,14}[0-9]$/
  @override
  bool isValid(String? value) {
    if (value == null) {
      return false;
    }
    var phone = _countryCode + value.removeChars("() ");
    var match = _regExp.hasMatch(phone);
    return match;
  }
}
