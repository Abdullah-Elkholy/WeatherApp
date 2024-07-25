import 'package:flutter_application/models/weather_model.dart';

class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class LoadingIconState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weatherModel;

  WeatherLoadedState(this.weatherModel);
}

class WeatherFailureState extends WeatherState {}
