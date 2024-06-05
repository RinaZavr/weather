import 'package:weather/domain/models/hour_model.dart';
import 'package:weather/domain/models/week_day_model.dart';

class CurrentDay {
  final double tempC;
  final double tempF;
  final String description;
  final String icon;
  final double windMph;
  final double windKph;
  final String windDir;
  final double pressureMb;
  final int humidity;
  final double feelslikeC;
  final double feelslikeF;
  final double dewpointC;
  final double dewPointF;
  final List<Hour> hours;
  final List<WeekDay> week;
  CurrentDay({
    required this.tempC,
    required this.tempF,
    required this.description,
    required this.icon,
    required this.windMph,
    required this.windKph,
    required this.windDir,
    required this.pressureMb,
    required this.humidity,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.dewpointC,
    required this.dewPointF,
    required this.hours,
    required this.week,
  });

  CurrentDay.fromJson(Map<String, dynamic> json)
      : tempC = json['current']['temp_c'],
        tempF = json['current']['temp_f'],
        description = json['current']['condition']['text'],
        icon = json['current']['condition']['icon'],
        windMph = json['current']['wind_mph'],
        windKph = json['current']['wind_kph'],
        windDir = json['current']['wind_dir'],
        pressureMb = json['current']['pressure_mb'],
        humidity = json['current']['humidity'],
        feelslikeC = json['current']['feelslike_c'],
        feelslikeF = json['current']['feelslike_f'],
        dewpointC = json['current']['dewpoint_c'],
        dewPointF = json['current']['dewpoint_f'],
        hours = (json['forecast']['forecastday'][0]['hour'] as List).map((hour) => Hour.fromJson(hour)).toList(),
        week = (json['forecast']['forecastday'] as List).map((week) => WeekDay.fromJson(week)).toList();
}
