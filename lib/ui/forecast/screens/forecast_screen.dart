import 'package:flutter/material.dart';
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
import 'package:weather/utils/utils.dart';

class ForecastScreen extends StatefulWidget {
  final double? lat;
  final double? lon;
  const ForecastScreen({super.key, this.lat, this.lon});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late List<List<Widget>> widgets;
  List<String> titles = ['Right now', 'This afternoon', 'This week'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => WeatherCubit()
          ..getWeather(lat: widget.lat, lon: widget.lon),
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoaded) {
              widgets = [
                [
                  NowMinInfoWidget(
                    day: state.currentDay,
                  ),
                  NowMaxInfoWidget(
                    day: state.currentDay,
                    sunrise: state.currentDay.week[0].sunrise,
                    sunset: state.currentDay.week[0].sunset,
                  ),
                ],
                [
                  AfternoonWidget(
                    maxTemp: Utils.getMaxTemp(state.currentDay.hours),
                    maxHumidity: Utils.getMaxHumidity(state.currentDay.hours),
                    hours: state.currentDay.hours.getRange(0, 8).toList(),
                  ),
                  AfternoonWidget(
                    maxTemp: Utils.getMaxTemp(state.currentDay.hours),
                    maxHumidity: Utils.getMaxHumidity(state.currentDay.hours),
                    hours: state.currentDay.hours
                        .getRange(8, state.currentDay.hours.length)
                        .toList(),
                  ),
                ],
                [
                  WeekWidget(
                    week: state.currentDay.week,
                  ),
                  WeekDetailWidget(
                    week: state.currentDay.week,
                  ),
                ],
              ];
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  title: LocationWidget(
                    currentDay: state.currentDay,
                  ),
                ),
                body: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  onRefresh: () =>
                      context.read<WeatherCubit>().getWeather(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) => CarouselTemplateWidget(
                        title: titles[index],
                        description: [
                          '',
                          '${state.currentDay.week[0].description}.',
                          '${Utils.getWeekDescription(state.currentDay.week)}.'
                        ][index],
                        firstWidget: widgets[index][0],
                        secondWidget: widgets[index][1],
                      ),
                      itemCount: titles.length,
                    ),
                  ),
                ),
              );
            }
            if (state is WeatherError) {
              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                onRefresh: () =>
                    context.read<WeatherCubit>().getWeather(),
                child: Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
