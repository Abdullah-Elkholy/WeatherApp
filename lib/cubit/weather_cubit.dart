import 'package:dio/dio.dart';
import 'package:flutter_application/cubit/weather_states.dart';
import 'package:flutter_application/models/weather_model.dart';
import 'package:flutter_application/services/weather_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());
  late WeatherModel weatherModel;
  late String error;

  getWeather({required String city, required String temperatureType}) async {
    emit(WeatherLoadingState());
    try {
      weatherModel = await GetWeatherService(Dio())
          .getCurrentWeather(cityName: city, temperatureType: temperatureType);
      emit(WeatherLoadedState());
    } catch (e) {
      emit(WeatherFailureState());
      error = e.toString();
    }
  }
}
