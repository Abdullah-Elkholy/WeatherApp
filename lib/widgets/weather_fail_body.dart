import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/weather_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherFailureBody extends StatelessWidget {
  const WeatherFailureBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String error = BlocProvider.of<WeatherCubit>(context).error;
    error = error.contains(':')
        ? error.replaceRange(0, error.lastIndexOf(':') + 2, '')
        : error; // returns error without unimportant details
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Text(
          error,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
