import 'package:get_it/get_it.dart';
import 'package:weather/domain/models/hour_model.dart';
import 'package:weather/domain/models/location_model.dart';
import 'package:weather/domain/models/week_day_model.dart';
import 'package:weather/domain/services/repository_sp.dart';

class CurrentDay {
  final LocationInfo location;
  final double temp;
  final String description;
  final String icon;
  final double wind;
  final String windDir;
  final double pressure;
  final int humidity;
  final double feelslike;
  final double dewpoint;
  final double visability;
  final double uv;
  final List<Hour> hours;
  final List<WeekDay> week;
  CurrentDay({
    required this.location,
    required this.temp,
    required this.description,
    required this.icon,
    required this.wind,
    required this.windDir,
    required this.pressure,
    required this.humidity,
    required this.feelslike,
    required this.dewpoint,
    required this.visability,
    required this.uv,
    required this.hours,
    required this.week,
  });

  CurrentDay.fromJson(Map<String, dynamic> json)
      : location = LocationInfo.fromJson(json['location']),
        temp = GetIt.I.get<RepositorySP>().currentUnit ==
                GetIt.I.get<RepositorySP>().units[0]
            ? json['current']['temp_c']
            : json['current']['temp_f'],
        description = json['current']['condition']['text'],
        icon = json['current']['condition']['icon'],
        wind = GetIt.I.get<RepositorySP>().currentUnit ==
                GetIt.I.get<RepositorySP>().units[0]
            ? json['current']['wind_kph']
            : json['current']['wind_mph'],
        windDir = json['current']['wind_dir'],
        pressure = json['current']['pressure_mb'],
        humidity = json['current']['humidity'],
        feelslike = GetIt.I.get<RepositorySP>().currentUnit ==
                GetIt.I.get<RepositorySP>().units[0]
            ? json['current']['feelslike_c']
            : json['current']['feelslike_f'],
        dewpoint = GetIt.I.get<RepositorySP>().currentUnit ==
                GetIt.I.get<RepositorySP>().units[0]
            ? json['current']['dewpoint_c']
            : json['current']['dewpoint_f'],
        visability = GetIt.I.get<RepositorySP>().currentUnit ==
                GetIt.I.get<RepositorySP>().units[0]
            ? json['current']['vis_km']
            : json['current']['vis_miles'],
        uv = json['current']['uv'],
        hours = (json['forecast']['forecastday'][0]['hour'] as List)
            .map((hour) => Hour.fromJson(hour))
            .toList(),
        week = (json['forecast']['forecastday'] as List)
            .map((week) => WeekDay.fromJson(week))
            .toList();
}
