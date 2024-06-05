import 'package:dio/dio.dart';
import 'package:weather/domain/models/current_day_model.dart';

class NetworkService {
  final String _address = 'https://api.weatherapi.com/v1';
  final String key = '9aab6f06a4904696b2483740240406';
  final dio = Dio();

  Future<CurrentDay?> getCurrentDay({String q = 'Omsk'}) async {
    var response = await dio.get(
        '$_address/forecast.json?key=$key&q=$q&days=8');
    return response.statusCode == 200 ? CurrentDay.fromJson(response.data) : null;
  }

}