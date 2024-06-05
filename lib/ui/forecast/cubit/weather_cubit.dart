import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/domain/models/current_day_model.dart';
import 'package:weather/domain/services/network_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  void getWeather({String city = 'Omsk'}) async {
    try {
      emit(WeatherLoading());
      CurrentDay? data = await GetIt.instance
          .get<NetworkService>()
          .getCurrentDay(q: city);
      emit(WeatherLoaded(currentDayModel: data!));
    } catch (e) {
      emit(WeatherError(error: 'Данные о погоде не найдены'));
    }
  }
}
