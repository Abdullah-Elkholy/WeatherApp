import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/weather_cubit.dart';
import 'package:flutter_application/cubit/weather_states.dart';
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
      child: Builder(builder: (context) {
        return BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            MaterialColor themeColor = Colors.blue; // Default color
            // Determine the color based on the current condition
            if (state is WeatherLoadedState) {
              themeColor = getThemeColor(state.weatherModel.condition);
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: WeatherApp(),
              theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: themeColor,
                appBarTheme: AppBarTheme(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.white,
                ),
                radioTheme: RadioThemeData(
                    fillColor: WidgetStateProperty.all(themeColor)),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor)),
                  floatingLabelStyle: TextStyle(color: themeColor),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// Getting different colors according to the condition provided
MaterialColor getThemeColor(String condition) {
  switch (condition) {
    // Clear and Sunny Conditions
    case 'Sunny':
    case 'Clear':
      return Colors.orange; // Brighter color for clear and sunny weather

    // Partly Cloudy
    case 'Partly Cloudy':
      return Colors.lightBlue; // Light blue for partially cloudy

    // Cloudy Conditions
    case 'Cloudy':
      return Colors.grey; // Neutral grey for cloudy conditions
    case 'Overcast':
      return Colors.blueGrey; // Darker grey for overcast

    // Mist and Fog Conditions
    case 'Mist':
    case 'Fog':
    case 'Freezing Fog':
      return Colors.blueGrey; // Muted blue-grey for mist and fog

    // Rain Conditions
    case 'Patchy Rain Possible':
    case 'Light Rain':
    case 'Patchy Light Rain':
    case 'Light Rain Shower':
    case 'Moderate Rain At Times':
    case 'Moderate Rain':
    case 'Heavy Rain At Times':
    case 'Heavy Rain':
    case 'Moderate Or Heavy Rain Shower':
    case 'Torrential Rain Shower':
      return Colors.blue; // Standard blue for various rain conditions

    // Snow Conditions
    case 'Patchy Snow Possible':
    case 'Patchy Light Snow':
    case 'Light Snow':
    case 'Light Snow Showers':
    case 'Blowing Snow':
    case 'Blizzard':
    case 'Heavy Snow':
    case 'Moderate Snow':
    case 'Moderate Or Heavy Snow Showers':
    case 'Patchy Heavy Snow':
    case 'Patchy Moderate Snow':
      return Colors.lightBlue; // Light blue for snow conditions

    // Sleet Conditions
    case 'Patchy Sleet Possible':
    case 'Light Sleet':
    case 'Light Sleet Showers':
    case 'Moderate Or Heavy Sleet':
    case 'Moderate Or Heavy Sleet Showers':
      return Colors.purple; // Purple for sleet conditions

    // Freezing Drizzle Conditions
    case 'Patchy Freezing Drizzle Possible':
    case 'Freezing Drizzle':
    case 'Light Freezing Rain':
    case 'Moderate Or Heavy Freezing Rain':
      return Colors.teal; // Teal for freezing drizzle and rain

    // Thunder Conditions
    case 'Thundery Outbreaks Possible':
    case 'Patchy Light Rain With Thunder':
    case 'Patchy Light Snow With Thunder':
    case 'Moderate Or Heavy Snow With Thunder':
    case 'Moderate Or Heavy Rain With Thunder':
      return Colors.deepPurple; // Deep purple for thunder and severe weather

    // Drizzle Conditions
    case 'Light Drizzle':
    case 'Patchy Light Drizzle':
      return Colors.lightBlue; // Light blue for light drizzle

    // Ice Pellets Conditions
    case 'Light Showers Of Ice Pellets':
    case 'Moderate Or Heavy Showers Of Ice Pellets':
    case 'Ice Pellets':
      return Colors.cyan; // Cyan for ice pellets

    // Default Condition
    default:
      return Colors.grey; // Default color if condition is not matched
  }
}
