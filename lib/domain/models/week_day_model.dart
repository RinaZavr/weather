// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class WeekDay {
  final DateTime date;
  final double maxTempC;
  final double maxTempF;
  final double minTempC;
  final double minTempF;
  final String decription;
  final String icon;
  final double windMph;
  final double windKph;
  final double humidity;
  final TimeOfDay sunrise;
  final TimeOfDay sunset;
  final String moonPhase;
  WeekDay({
    required this.date,
    required this.maxTempC,
    required this.maxTempF,
    required this.minTempC,
    required this.minTempF,
    required this.decription,
    required this.icon,
    required this.windMph,
    required this.windKph,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.moonPhase,
  });

  WeekDay.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['forecast']['forecastday']['date']),
        maxTempC = json['forecast']['forecastday']['day']['maxtemp_c'],
        maxTempF = json['forecast']['forecastday']['day']['maxtemp_f'],
        minTempC = json['forecast']['forecastday']['day']['mintemp_c'],
        minTempF = json['forecast']['forecastday']['day']['mintemp_f'],
        decription = json['forecast']['forecastday']['day']['condition']['text'],
        icon = json['forecast']['forecastday']['day']['condition']['icon'],
        windMph = json['forecast']['forecastday']['day']['maxwind_mph'],
        windKph = json['forecast']['forecastday']['day']['maxwind_kph'],
        humidity = json['forecast']['forecastday']['day']['avghumidity'],
        sunrise = TimeOfDay.fromDateTime(DateTime.parse(json['forecast']['forecastday']['astro']['sunrise'])),
        sunset = TimeOfDay.fromDateTime(DateTime.parse(json['forecast']['forecastday']['astro']['sunset'])),
        moonPhase = json['forecast']['forecastday']['astro']['moon_phase'];
}
