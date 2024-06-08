import 'package:flutter/material.dart';
import 'package:weather/domain/models/current_day_model.dart';
import 'package:weather/ui/forecast/widgets/image_widget.dart';

class NowMinInfoWidget extends StatelessWidget {
  final CurrentDay day;
  const NowMinInfoWidget({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${day.description}.',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidget(icon: day.icon, width: 100),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    '${day.tempC.toStringAsFixed(0)}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Feels like ${day.feelslikeC.toStringAsFixed(0)}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
