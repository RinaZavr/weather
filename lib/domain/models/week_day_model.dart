import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:weather/domain/models/hour_model.dart';
import 'package:weather/domain/services/repository_sp.dart';

class WeekDay {
  final DateTime date;
  final double maxTemp;
  final double minTempC;
  final String description;
  final String icon;
  final double wind;
  final int humidity;
  final TimeOfDay sunrise;
  final TimeOfDay sunset;
  final String moonPhase;
  final List<Hour> hours;
  WeekDay({
    required this.date,
    required this.maxTemp,
    required this.minTempC,
    required this.description,
    required this.icon,
    required this.wind,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.moonPhase,
    required this.hours,
  });

  WeekDay.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['date']),
        maxTemp = GetIt.I.get<RepositorySP>().currentUnit ==
                GetIt.I.get<RepositorySP>().units[0]
            ? json['day']['maxtemp_c']
            : json['day']['maxtemp_f'],
        minTempC = GetIt.I.get<RepositorySP>().currentUnit ==
                GetIt.I.get<RepositorySP>().units[0]
            ? json['day']['mintemp_c']
            : json['day']['mintemp_f'],
        description = json['day']['condition']['text'],
        icon = json['day']['condition']['icon'],
        wind = GetIt.I.get<RepositorySP>().currentUnit ==
                GetIt.I.get<RepositorySP>().units[0]
            ? json['day']['maxwind_kph']
            : json['day']['maxwind_mph'],
        humidity = json['day']['avghumidity'],
        sunrise = TimeOfDay.fromDateTime(
            DateFormat("h:mm a").parse(json['astro']['sunrise'])),
        sunset = TimeOfDay.fromDateTime(
            DateFormat("h:mm a").parse(json['astro']['sunset'])),
        moonPhase = json['astro']['moon_phase'],
        hours = (json['hour'] as List).map((e) => Hour.fromJson(e)).toList();
}
