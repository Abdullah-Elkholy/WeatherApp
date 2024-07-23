import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/weather_icon_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherIconCubit extends Cubit<WeatherIconState> {
  WeatherIconCubit() : super(WeatherIconLoading());
  late Widget weatherIcon;

  getWeatherIcon({required String iconLink}) {
    weatherIcon = Image.network(
      iconLink,
      width: 80,
      height: 80,
      fit: BoxFit.fill,
    );
    emit(WeatherIconLoaded());
  }
}
