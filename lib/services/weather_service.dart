import 'package:dio/dio.dart';
import 'package:flutter_application/models/weather_model.dart';

class GetWeatherService {
  final Dio dio;
  final String baseURL = 'http://api.weatherapi.com/v1';
  final String apiKey = '557160702e3c451f8f4124101242107';

  GetWeatherService(this.dio);

  Future<WeatherModel> getCurrentWeather(
      {required String cityName, required String temperatureType}) async {
    try {
      Response response = await dio
          .get('$baseURL/forecast.json?key=$apiKey&q=$cityName&days=1');
      return WeatherModel.fromJSON(
          json: response.data, tempType: temperatureType);
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['error']['message'] ??
          'Oops There was an error, try later';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Oops There was an error, try later');
    }
  }
}
