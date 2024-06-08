import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather/domain/models/hour_model.dart';
import 'package:weather/domain/models/week_day_model.dart';

class Utils {
  static String getWeekDescription(List<WeekDay> week) {
    Map<String, int> info = {};
    List<int> temps = [];

    for (var element in week) {
      info[element.description] = (info[element.description] ?? 0) + 1;
      temps.add(element.maxTempC.ceil());
    }
    int maxInfo = info.values.reduce(max);
    int maxTemp = temps.reduce(max);
    String maxInfoKey = info.keys.firstWhere((element) => info[element] == maxInfo);
    return '$maxInfoKey for most of the week, with highs in the $maxTemp°s all week';
  }

  static String getWindDir(String dir) {
    switch (dir.toLowerCase()) {
      case 'n':
        return 'North';
      case 'nne':
        return 'North-North-East';
      case 'ne':
        return 'North-East';
      case 'ene':
        return 'East-North-East';
      case 'e':
        return 'East';
      case 'ese':
        return 'East-South-East';
      case 'se':
        return 'South-East';
      case 'sse':
        return 'South-South-East';
      case 's':
        return 'South';
      case 'ssw':
        return 'South-South-West';
      case 'sw':
        return 'South-West';
      case 'wsw':
        return 'West-South-West';
      case 'w':
        return 'West';
      case 'wnw':
        return 'West-North-West';
      case 'nw':
        return 'North-West';
      case 'nnw':
        return 'North-North-West';
      default:
        return dir;
    }
  }

  static String getHumidityText(int humidity) {
    switch(humidity) {
      case <= 10:
        return 'Feels dry';
      case <= 20:
        return 'Feels more comfortable';
      case <= 30:
        return 'Feels pleasant';
      case <= 40:
        return 'Feels refreshing and moisturized';
      case <= 50:
        return 'Feels ideal for most people';
      case <= 60:
        return 'Feels slightly humid';
      case <= 70:
        return 'Feels quite humid';
      default:
        return 'Feels very humid';
    }
  }

  static String daylightHours(TimeOfDay sunrise, TimeOfDay sunset) {
    int hours = sunset.hour - sunrise.hour;
    double minuteInHours = ((sunset.minute - sunrise.minute) + hours * 60) / 60;
    return ((minuteInHours * 10).ceil() / 10).toString();
  }

  static double getMaxTemp(List<Hour> list) {
    return list.reduce((a, b) => a.tempC > b.tempC ? a : b).tempC;
  }

  static double getMaxHumidity(List<Hour> list) {
    return list.reduce((a, b) => a.humidity > b.humidity ? a : b).humidity.toDouble();
  }

  static String getWindImage(String dir) {
    switch (dir.toLowerCase()) {
      case 'n':
        return 'assets/wind/n.png';
      case 'nne':
      case 'ne':
      case 'ene':
        return 'assets/wind/ne.png';
      case 'e':
        return 'assets/wind/e.png';
      case 'ese':
      case 'se':
      case 'sse':
        return 'assets/wind/se.png';
      case 's':
        return 'assets/wind/s.png';
      case 'ssw':
      case 'sw':
      case 'wsw':
        return 'assets/wind/sw.png';
      case 'w':
        return 'assets/wind/w.png';
      case 'wnw':
      case 'nw':
      case 'nnw':
        return 'assets/wind/nw.png';
      default:
        return 'assets/wind/s.png';
    }
  }

  static String getHumidityImage(int humidity) {
    switch (humidity) {
      case <= 30:
        return 'assets/humidity/30.png';
      case <= 50:
        return 'assets/humidity/50.png';
      default:
        return 'assets/humidity/100.png';
    }
  }

  static String getUVImage(double uv) {
    if(uv < 11) {
      return 'assets/uv/${uv.toInt()}.png';
    }
    return 'assets/uv/11.png';
  }

  static String getSunsetImage() {
    return 'assets/sunset.png';
  }

  static String getPressureImage() {
    return 'assets/pressure.png';
  }
}
