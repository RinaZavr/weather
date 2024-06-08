import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/domain/models/week_day_model.dart';
import 'package:weather/ui/forecast/widgets/image_widget.dart';

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('EEE').format(week.date).toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          week.date.day.toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ImageWidget(icon: week.icon, width: 30),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${week.description}. ${week.windKph}km/h winds.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
