import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather/ui/forecast/cubit/weather_cubit.dart';
import 'package:weather/ui/forecast/widgets/afternoon_widget.dart';
import 'package:weather/ui/forecast/widgets/carousel_template_widget.dart';
import 'package:weather/ui/forecast/widgets/location_widget.dart';
import 'package:weather/ui/forecast/widgets/now_max_info_widget.dart';
import 'package:weather/ui/forecast/widgets/now_min_info_widget.dart';
import 'package:weather/ui/forecast/widgets/week_detail_widget.dart';
import 'package:weather/ui/forecast/widgets/week_widget.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<String> titles = ['Right now', 'This afternoon', 'This week'];
  List<String> descriptions = ['', 'Rain', 'Rain rain rain rain'];
  List<double> numbers = [
    26,
    26,
    25,
    25,
    25,
    24,
    23,
    21,
    20,
    19,
    18,
    17,
    16,
    16,
    16,
    16
  ];
  List<double> numbersMin = [
    9,
    16,
    14,
    12,
    11,
    12,
    12,
    13,
  ];
  List<double> numbersPer = [40, 65, 65, 40, 45, 50, 45, 40];
  double average = 0;
  late List<List<Widget>> widgets;

  @override
  void initState() {
    super.initState();
    widgets = [
      [
        const NowMinInfoWidget(),
        const NowMaxInfoWidget(),
      ],
      [
        AfternoonWidget(
            values: numbers.getRange(0, 8).toList(), max: numbers.reduce(max)),
        AfternoonWidget(
            values: numbers.getRange(8, numbers.length).toList(),
            max: numbers.reduce(max)),
      ],
      [
        WeekWidget(
          maxVal: numbers.reduce(max),
          maxPer: numbersPer.reduce(max),
          values: numbers.getRange(0, 8).toList(),
          valuesMin: numbersMin,
          valuesPer: numbersPer,
        ),
        WeekDetailWidget(
          values: numbersMin,
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => WeatherCubit()..getWeather(city: 'Omsk'),
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoaded) {
              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                onRefresh: () => context.read<WeatherCubit>().getWeather(city: 'Omsk'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: LocationWidget(),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => CarouselTemplateWidget(
                            title: titles[index],
                            description: descriptions[index],
                            firstWidget: widgets[index][0],
                            secondWidget: widgets[index][1],
                          ),
                          itemCount: titles.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is WeatherError) {
              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                onRefresh: () => context.read<WeatherCubit>().getWeather(city: 'Omsk'),
                child: Center(child: Text(state.error, style: const TextStyle(color: Colors.red))));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
