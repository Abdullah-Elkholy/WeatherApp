import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/weather_cubit.dart';
import 'package:flutter_application/cubit/weather_icon_cubit.dart';
import 'package:flutter_application/cubit/weather_states.dart';
import 'package:flutter_application/views/search_view.dart';
import 'package:flutter_application/widgets/initial_body.dart';
import 'package:flutter_application/widgets/weather_fail_body.dart';
import 'package:flutter_application/widgets/weather_load_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchView()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitialState) {
            return NoWeatherBody();
          } else if (state is WeatherLoadedState) {
            return BlocProvider(
              create: (context) => WeatherIconCubit(),
              child: WeatherLoadedBody(),
            );
          } else if (state is WeatherLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherFailureState) {
            return WeatherFailureBody();
          } else {
            return Text(
              'Oops, There was an unexpected error,\nplease try again later...',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            );
          }
        },
      ),
    );
  }
}
