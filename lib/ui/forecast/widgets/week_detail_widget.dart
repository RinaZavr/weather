import 'package:flutter/material.dart';

class WeekDetailWidget extends StatefulWidget {
  final List<double> values;
  const WeekDetailWidget({super.key, required this.values});

  @override
  State<WeekDetailWidget> createState() => _WeekDetailWidgetState();
}

class _WeekDetailWidgetState extends State<WeekDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = 0; index < widget.values.length; index++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Column(
                children: [
                  Text(
                    'WED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '5',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.circle,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'lalala ${widget.values[index]}km/h winds.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
