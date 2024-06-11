import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/domain/models/hour_model.dart';
import 'package:weather/ui/forecast/widgets/image_widget.dart';
import 'package:weather/utils/consts/color_consts.dart';

class AfternoonWidget extends StatefulWidget {
  final List<Hour> hours;
  final double maxTemp;
  final double maxHumidity;

  const AfternoonWidget(
      {super.key,
      required this.hours,
      required this.maxTemp,
      required this.maxHumidity});

  @override
  State<AfternoonWidget> createState() => _AfternoonWidgetState();
}

class _AfternoonWidgetState extends State<AfternoonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          for (Hour hour in widget.hours)
            Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(
                    left: 2,
                    right: 2,
                    top: hour.temp > 50 ? widget.maxTemp - hour.temp : widget.maxTemp * 2 - hour.temp * 2,
                  ),
                  padding: const EdgeInsets.only(top: 4),
                  height: hour.temp > 50 ? hour.temp : hour.temp * 2,
                  width: MediaQuery.of(context).size.width / 8 - 6,
                  decoration: BoxDecoration(
                    color: ThemeProvider.controllerOf(context).theme.data.primaryColorLight,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    '${hour.temp.toStringAsFixed(0)}°',
                    style: ThemeProvider.controllerOf(context).theme.data.textTheme.titleSmall,
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Text(
                    '${hour.time.hour.toString().padLeft(2, '0')}:${hour.time.minute.toString().padLeft(2, '0')}',
                    style: ThemeProvider.controllerOf(context).theme.data.textTheme.labelMedium,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(
                      left: 2,
                      right: 2,
                      bottom: (widget.maxHumidity / 3 + 50) -
                          (hour.humidity / 3 + 50),
                          ),
                  padding: const EdgeInsets.only(top: 4),
                  height: hour.humidity / 3 + 50,
                  width: MediaQuery.of(context).size.width / 8 - 6,
                  decoration: const BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageWidget(icon: hour.icon, width: 30),
                      Text(
                        '${hour.humidity}%',
                        style: ThemeProvider.controllerOf(context).theme.data.textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
