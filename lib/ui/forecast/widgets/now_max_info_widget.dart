import 'package:flutter/material.dart';
import 'package:weather/domain/models/current_day_model.dart';
import 'package:weather/utils/utils.dart';

class NowMaxInfoWidget extends StatelessWidget {
  final CurrentDay day;
  final TimeOfDay sunrise;
  final TimeOfDay sunset;
  const NowMaxInfoWidget(
      {super.key,
      required this.day,
      required this.sunrise,
      required this.sunset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInfo(
          Utils.getWindImage(day.windDir),
            '${day.windKph.toStringAsFixed(0)}km/h winds from the ${Utils.getWindDir(day.windDir)}.\nVilability ${day.visKm.toStringAsFixed(0)}+ kilometers.'),
        buildInfo(
          Utils.getHumidityImage(day.humidity),
            'Humidity ${day.humidity}% • Dewpoint ${day.dewpointC.toStringAsFixed(0)}°\n${Utils.getHumidityText(day.humidity)}.'),
        buildInfo(
          Utils.getPressureImage(),
          'Presure ${day.pressureMb.toStringAsFixed(0)}mb and steady.'),
        buildInfo(
          Utils.getSunsetImage(),
            'Sunrise ${sunrise.format(context)} -> Sunset ${sunset.format(context)}.\n${Utils.daylightHours(sunrise, sunset)} hours of daylight.'),
        buildInfo(
          Utils.getUVImage(day.uv),
          'Moderate UV levels.'),
      ],
    );
  }

  Widget buildInfo(String icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Image.asset(icon, height: 35, width: 40,),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
