import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
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
          style: ThemeProvider.controllerOf(context).theme.data.textTheme.titleMedium,
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
                    '${day.temp.toStringAsFixed(0)}°',
                    style: ThemeProvider.controllerOf(context).theme.data.textTheme.bodyLarge,
                  ),
                  Text(
                    'Feels like ${day.feelslike.toStringAsFixed(0)}°',
                    style: ThemeProvider.controllerOf(context).theme.data.textTheme.bodyMedium,
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
