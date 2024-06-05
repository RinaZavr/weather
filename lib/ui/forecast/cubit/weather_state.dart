part of 'weather_cubit.dart';

sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}
final class WeatherLoading extends WeatherState {}
final class WeatherLoaded extends WeatherState {
  final CurrentDay currentDayModel;
  WeatherLoaded({
    required this.currentDayModel
  });
}
final class WeatherError extends WeatherState {
  final String error;
  WeatherError({required this.error});
}
