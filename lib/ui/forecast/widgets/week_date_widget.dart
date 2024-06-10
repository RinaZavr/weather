import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theme_provider/theme_provider.dart';

class WeekDateWidget extends StatelessWidget {
  final DateTime date;
  const WeekDateWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(DateFormat('EEE').format(date).toUpperCase(),
            style: ThemeProvider.controllerOf(context)
                .theme
                .data
                .textTheme
                .labelMedium),
        Text(date.day.toString(),
            style: ThemeProvider.controllerOf(context)
                .theme
                .data
                .textTheme
                .labelSmall),
      ],
    );
  }
}
