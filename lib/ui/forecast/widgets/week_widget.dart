import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/domain/models/week_day_model.dart';
import 'package:weather/ui/forecast/widgets/image_widget.dart';
import 'package:weather/ui/forecast/widgets/week_date_widget.dart';
import 'package:weather/utils/consts/color_consts.dart';

class WeekWidget extends StatefulWidget {
  final List<WeekDay> week;
  const WeekWidget({
    super.key,
    required this.week,
  });

  @override
  State<WeekWidget> createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<WeekWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 350),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2 - 45),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      height: 300 / 8,
                      width: widget.week[index].humidity + 38,
                      decoration: const BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.week[index].humidity.toStringAsFixed(0)}%',
                            style: ThemeProvider.controllerOf(context).theme.data.textTheme.titleSmall,
                          ),
                          ImageWidget(icon: widget.week[index].icon, width: 30),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 45,
                  child: WeekDateWidget(date: widget.week[index].date,),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2 - 45),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      height: 300 / 8,
                      width: widget.week[index].minTempC * 4 + 38,
                      decoration: const BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            color: AppColors.darkYellow,
                            height: 300 / 8,
                            width: 30,
                            child: Text(
                              '${widget.week[index].minTempC.toStringAsFixed(0)}°',
                              style: ThemeProvider.controllerOf(context).theme.data.textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(
                              '${widget.week[index].maxTempC.toStringAsFixed(0)}°',
                              style: ThemeProvider.controllerOf(context).theme.data.textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: 8,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
