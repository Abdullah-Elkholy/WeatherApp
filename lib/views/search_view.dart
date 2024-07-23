import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/weather_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String temperatureType = '°C';
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
                hintText: 'Enter your city name',
              ),
              onSubmitted: (cityName) {
                BlocProvider.of<WeatherCubit>(context).getWeather(
                    city: cityName, temperatureType: temperatureType);
                Navigator.pop(context);
              },
            ),
            Row(
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
                SizedBox(width: 12),
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
          ],
        ),
      ),
    );
  }
}

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({super.key});

//   @override
//   _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   var _site = '°C';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'City Name',
//                 hintText: 'Enter your city name',
//               ),
//               onSubmitted: (cityName) {
//                 BlocProvider.of<WeatherCubit>(context)
//                     .getWeather(city: cityName);
//                 Navigator.pop(context);
//               },
//             ),
//             Row(
//               children: [
//                 Radio(
//                   value: '°C',
//                   groupValue: _site,
//                   onChanged: (value) {
//                     setState(() {
//                       _site = value!;
//                     });
//                   },
//                 ),
//                 Text('°Celsius'),
//                 SizedBox(width: 12),
//                 Radio(
//                   value: '°F',
//                   groupValue: _site,
//                   onChanged: (value) {
//                     setState(() {
//                       _site = value!;
//                     });
//                   },
//                 ),
//                 Text('°Fahrenheit'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
