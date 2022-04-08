import 'package:flutter/widgets.dart';

import 'navigator_of.dart';

class MediaQueryOf {
  static MediaQueryData of() => MediaQuery.of(NavigatorOf.of().context);
}
