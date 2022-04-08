import 'package:flutter/material.dart';

extension TimeOfDayToString on TimeOfDay {
  String toTimeString() {
    var strHour = hour.toString();
    var strMinute = minute.toString();
    var strHour0 = hour <= 9 ? '0$strHour' : hour;
    var strMinute0 = minute <= 9 ? '0$strMinute' : strMinute;
    return '$strHour0 : $strMinute0';
  }

  String toDurationString() {
    if ((hour == 0) && (minute == 0)) {
      return "0 h";
    }
    String strHour = hour == 0 ? '' : '${hour.toString()} h';
    String strMinute = minute == 0
        ? ''
        : ((hour > 0) && (minute <= 9))
            ? '0$minute m'
            : '$minute m';
    return '$strHour $strMinute';
  }
}
