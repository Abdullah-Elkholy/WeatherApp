import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/weather_cubit.dart';
import 'package:flutter_application/cubit/weather_icon_cubit.dart';
import 'package:flutter_application/cubit/weather_icon_states.dart';
import 'package:flutter_application/models/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherLoadedBody extends StatelessWidget {
  const WeatherLoadedBody({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherModel weather = BlocProvider.of<WeatherCubit>(context).weatherModel;

    BlocProvider.of<WeatherIconCubit>(context).getWeatherIcon(
        iconLink:
            BlocProvider.of<WeatherCubit>(context).weatherModel.iconImage);

    return Column(
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
                    return BlocProvider.of<WeatherIconCubit>(context)
                        .weatherIcon;
                  }
                },
              ),
            ),
            SizedBox(width: 34),
            Text(
              '${weather.temp}${weather.tempType}',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 38),
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
    );
  }
}
