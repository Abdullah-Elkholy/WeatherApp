import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/weather_cubit.dart';
import 'package:flutter_application/cubit/weather_icon_cubit.dart';
import 'package:flutter_application/cubit/weather_icon_states.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherLoadedBody extends StatelessWidget {
  const WeatherLoadedBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Gets the needed object of the data prepared to be used
    WeatherModel weather = BlocProvider.of<WeatherCubit>(context).weatherModel;

    // Initializes target widget by passing needed parameters
    BlocProvider.of<WeatherIconCubit>(context)
        .getWeatherIcon(iconLink: weather.iconImage);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            getThemeColor(weather.condition)[500]!,
            getThemeColor(weather.condition)[300]!,
            getThemeColor(weather.condition)[50]!,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  weather.cityName,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 4),
                Text(
                  weather.countryName,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            Text(
              'Last updated at: ${weather.time}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: BlocBuilder<WeatherIconCubit, WeatherIconState>(
                    builder: (context, state) {
                      if (state is WeatherIconLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        // state is WeatherIconLoaded
                        // Gets the needed object of the data prepared to be used
                        return BlocProvider.of<WeatherIconCubit>(context)
                            .weatherIcon;
                      }
                    },
                  ),
                ),
                SizedBox(width: 36),
                Text(
                  '${weather.temp}${weather.tempType}',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 36),
                Column(
                  children: [
                    Text(
                      'maxTemp: ${weather.maxTemp}${weather.tempType}',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'minTemp: ${weather.minTemp}${weather.tempType}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              weather.condition,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
