import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:weather/domain/models/current_day_model.dart';
import 'package:weather/domain/services/network_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  void getWeather({double? lat, double? lon}) async {
    try {
      emit(WeatherLoading());
      CurrentDay data = (await GetIt.instance.get<NetworkService>().getCurrentDay(
          q: '${lat ?? GetIt.instance.get<LocationData>().latitude ?? 0},${lon ?? GetIt.instance.get<LocationData>().longitude ?? 0}'))!;
      data.hours
          .removeWhere((element) => element.time.hour < TimeOfDay.now().hour);
      if (data.hours.length < 16) {
        int val = 16 - data.hours.length;
        for (int i = 0; i < val; i++) {
          data.hours.add(data.week[1].hours[i]);
        }
      }
      emit(WeatherLoaded(currentDay: data));
    } catch (e) {
      emit(WeatherError(error: 'Данные о погоде не найдены'));
    }
  }
}
