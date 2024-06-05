import 'package:flutter/material.dart';

class Hour {
  final TimeOfDay time;
  final double tempC;
  final double tempF;
  final String icon;
  final double humidity;
  Hour({
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.icon,
    required this.humidity,
  });

  Hour.fromJson(Map<String, dynamic> json)
      : time = TimeOfDay.fromDateTime(DateTime.parse(json['time'])),
        tempC = json['temp_c'],
        tempF = json['temp_f'],
        icon = json['condition']['icon'],
        humidity = json['humidity'];
}