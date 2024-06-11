import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/domain/services/repository_sp.dart';

class Hour {
  TimeOfDay time;
  final double temp;
  final String icon;
  final int humidity;
  Hour({
    required this.time,
    required this.temp,
    required this.icon,
    required this.humidity,
  });

  Hour.fromJson(Map<String, dynamic> json)
      : time = TimeOfDay.fromDateTime(DateTime.parse(json['time'])),
        temp = GetIt.I.get<RepositorySP>().currentUnit ==
                GetIt.I.get<RepositorySP>().units[0]
            ? json['temp_c']
            : json['temp_f'],
        icon = json['condition']['icon'],
        humidity = json['humidity'];
}
