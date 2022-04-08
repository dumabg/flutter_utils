import 'package:dart_utils/extensions/string/remove_chars.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CPFValidator extends TextFieldValidator {
  CPFValidator({required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    if (value == null) {
      return false;
    }
    //https://github.com/this-empathy/dart_validator/blob/master/lib/src/cpf.dart
    var cpf = value.removeSpecialChars().removeWhiteSpace();

    if (cpf.length > 11 || cpf.length < 11) return false;
    if (_allEqual(cpf)) return false;

    int sum, rest;
    sum = 0;

    for (var i = 1; i <= 9; i++) {
      sum = sum + int.parse(cpf.substring(i - 1, i)) * (11 - i);
    }
    rest = (sum * 10) % 11;

    if (rest == 10 || rest == 11) rest = 0;
    if (rest != int.parse(cpf.substring(9, 10))) return false;

    sum = 0;
    for (var i = 1; i <= 10; i++) {
      sum = sum + int.parse(cpf.substring(i - 1, i)) * (12 - i);
    }
    rest = (sum * 10) % 11;

    if (rest == 10 || rest == 11) rest = 0;
    if (rest != int.parse(cpf.substring(10, 11))) return false;

    return true;
  }

  bool _allEqual(String s) {
    String c = s[0];
    for (int i = 1; i < s.length; i++) {
      if (s[i] != c) {
        return false;
      }
    }
    return true;
  }
}
