// ignore_for_file: prefer_single_quotes

import 'package:flutter/material.dart';

extension TimeOfDayToString on TimeOfDay {
  String toTimeString() {
    final strHour = hour.toString();
    final strMinute = minute.toString();
    final strHour0 = hour <= 9 ? '0$strHour' : hour;
    final strMinute0 = minute <= 9 ? '0$strMinute' : strMinute;
    return '$strHour0 : $strMinute0';
  }

  String toDurationString() {
    if ((hour == 0) && (minute == 0)) {
      return '0 h';
    }
    final String strHour = hour == 0 ? '' : '$hour h';
    final String strMinute = minute == 0
        ? ''
        : ((hour > 0) && (minute <= 9))
            ? '0$minute m'
            : '$minute m';
    return '$strHour $strMinute';
  }
}
