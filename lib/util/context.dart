import 'package:flutter/widgets.dart';
import 'package:flutter_utils/util/navigator_of.dart';

BuildContext currentBuildContext() =>
    NavigatorOf.navigatorKey.currentState!.context;
