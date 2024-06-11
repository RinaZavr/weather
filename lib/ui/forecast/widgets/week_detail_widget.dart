import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/domain/models/week_day_model.dart';
import 'package:weather/ui/forecast/widgets/image_widget.dart';
import 'package:weather/ui/forecast/widgets/week_date_widget.dart';

class WeekDetailWidget extends StatefulWidget {
  final List<WeekDay> week;
  const WeekDetailWidget({super.key, required this.week});

  @override
  State<WeekDetailWidget> createState() => _WeekDetailWidgetState();
}

class _WeekDetailWidgetState extends State<WeekDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          for (WeekDay week in widget.week)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: WeekDateWidget(date: week.date,),
                  ),
                  ImageWidget(icon: week.icon, width: 30),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${week.description}. ${week.wind}km/h winds.',
                    style: ThemeProvider.controllerOf(context).theme.data.textTheme.labelLarge,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
