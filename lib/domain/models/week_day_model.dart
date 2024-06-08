// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/domain/models/hour_model.dart';

class WeekDay {
  final DateTime date;
  final double maxTempC;
  final double maxTempF;
  final double minTempC;
  final double minTempF;
  final String description;
  final String icon;
  final double windMph;
  final double windKph;
  final int humidity;
  final TimeOfDay sunrise;
  final TimeOfDay sunset;
  final String moonPhase;
  final List<Hour> hours;
  WeekDay({
    required this.date,
    required this.maxTempC,
    required this.maxTempF,
    required this.minTempC,
    required this.minTempF,
    required this.description,
    required this.icon,
    required this.windMph,
    required this.windKph,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.moonPhase,
    required this.hours,
  });

  WeekDay.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['date']),
        maxTempC = json['day']['maxtemp_c'],
        maxTempF = json['day']['maxtemp_f'],
        minTempC = json['day']['mintemp_c'],
        minTempF = json['day']['mintemp_f'],
        description = json['day']['condition']['text'],
        icon = json['day']['condition']['icon'],
        windMph = json['day']['maxwind_mph'],
        windKph = json['day']['maxwind_kph'],
        humidity = json['day']['avghumidity'],
        sunrise = TimeOfDay.fromDateTime(DateFormat("h:mm a").parse(json['astro']['sunrise'])),
        sunset = TimeOfDay.fromDateTime(DateFormat("h:mm a").parse(json['astro']['sunset'])),
        moonPhase = json['astro']['moon_phase'],
        hours = (json['hour'] as List).map((e) => Hour.fromJson(e)).toList();
}
