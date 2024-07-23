import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/weather_cubit.dart';
import 'package:flutter_application/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeatherApp(),
      ),
    );
  }
}
