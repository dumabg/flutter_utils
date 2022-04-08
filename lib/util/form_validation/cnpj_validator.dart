import 'package:form_field_validator/form_field_validator.dart';
import 'package:dart_utils/extensions/string/remove_chars.dart';

class CNPJValidator extends TextFieldValidator {
  CNPJValidator({required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    if (value == null) {
      return false;
    }
    //https://github.com/this-empathy/dart_validator/blob/master/lib/src/cnpj.dart
    String cnpj = value.removeSpecialChars().removeWhiteSpace();

    if (cnpj.length > 14 || cnpj.length < 14) return false;
    if (_allEqual(cnpj)) return false;

    final int t = cnpj.length - 2;
    final String d = cnpj.substring(t);
    final int d1 = int.parse(d[0]);
    final d2 = int.parse(d[1]);

    return _calc(cnpj, t) == d1 && _calc(cnpj, t + 1) == d2;
  }

  int _calc(String cnpj, int x) {
    final String n = cnpj.substring(0, x);
    int y = x - 7, s = 0, r = 0;

    for (var i = x; i >= 1; i--) {
      s += int.parse(n[x - i]) * y--;
      if (y < 2) y = 9;
    }

    r = 11 - (s % 11);
    return r > 9 ? 0 : r;
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
