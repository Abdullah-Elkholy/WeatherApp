import 'package:dio/dio.dart';
import 'package:flutter_application/models/weather_model.dart';

class GetWeatherService {
  final Dio dio;
  final String baseURL = 'http://api.weatherapi.com/v1';
  final String apiKey = '557160702e3c451f8f4124101242107';

  GetWeatherService(this.dio);

  Future<WeatherModel> getCurrentWeather(
      {required String cityName, required String temperatureType}) async {
    const String defaultErrMessage = 'Oops There was an error, try later';
    const String emptyFieldErrMessage = 'Please enter your city name.';

    try {
      Response response = await dio
          .get('$baseURL/forecast.json?key=$apiKey&q=$cityName&days=1');
      return WeatherModel.fromJSON(
          json: response.data, tempType: temperatureType);
    } on DioException catch (e) {
      final String errorMessage =
          cityName.isEmpty // Checks for empty text field
              // equivalent to 'e.response.data["error"]["code"] == 1003'
              ? emptyFieldErrMessage
              : e.response?.data['error']['message'] ??
                  'Please check your internet connection'; // nullErrMessage
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(defaultErrMessage);
    }
  }
}
