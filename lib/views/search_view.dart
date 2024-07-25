import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/weather_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String temperatureType = '°C'; // Default temperature
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'City Name',
                hintText: 'e.g. New York',
              ),
              onSubmitted: (cityName) {
                BlocProvider.of<WeatherCubit>(context).getWeather(
                    city: cityName, temperatureType: temperatureType);
                Navigator.pop(context);
              },
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      temperatureType = '°C';
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        value: '°C',
                        groupValue: temperatureType,
                        onChanged: (value) {
                          setState(() {
                            temperatureType = value!;
                          });
                        },
                      ),
                      Text('Celsius (°C)'),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      temperatureType = '°F';
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        value: '°F',
                        groupValue: temperatureType,
                        onChanged: (value) {
                          setState(() {
                            temperatureType = value!;
                          });
                        },
                      ),
                      Text('Fahrenheit (°F)'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
