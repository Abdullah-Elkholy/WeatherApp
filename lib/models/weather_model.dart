class WeatherModel {
  final String cityName;
  final String countryName;
  final String temp;
  final String minTemp;
  final String maxTemp;
  final String iconImage;
  final String condition;
  final String time;
  final String tempType;

  WeatherModel(
      {required this.tempType,
      required this.cityName,
      required this.countryName,
      required this.temp,
      required this.minTemp,
      required this.maxTemp,
      required this.iconImage,
      required this.condition,
      required this.time});

  factory WeatherModel.fromJSON({required json, required String tempType}) {
    var data = json['forecast']['forecastday'][0]['day'];
    return WeatherModel(
      cityName: json['location']['name'],
      countryName: json['location']['country'],
      condition: _capitalizeSentence(data['condition']['text']),
      temp: _tempTypeCheck(data['avgtemp_c'], data['avgtemp_f'], tempType),
      minTemp: _tempTypeCheck(data['mintemp_c'], data['mintemp_f'], tempType),
      maxTemp: _tempTypeCheck(data['maxtemp_c'], data['maxtemp_f'], tempType),
      iconImage: _httpsCheck(data['condition']['icon']),
      time: _timeFromDateTime(json['current']['last_updated']),
      tempType: tempType,
    );
  }
}
//  Some functions to make the data fit to be displayed

// Sends related temperature data according to given temperature type
String _tempTypeCheck(
    double tempCelsius, double tempFahrenheit, String tempType) {
  double temp = tempType == '°C' ? tempCelsius : tempFahrenheit;
  return temp.round().toString();
}

// Checks for https in the icon link
String _httpsCheck(String link) {
  String checkedLink = link.contains('https:') ? link : 'https:$link';
  return checkedLink;
}

// Capitalizes first letter of a string
extension StringExtensions on String {
  String _capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

// Capitalizes each word in a string
String _capitalizeSentence(String sentence) {
  String capitalizedSentence = sentence.trimRight().contains(' ')
      ? sentence.split(' ').map((word) => word._capitalize()).join(' ')
      : sentence;
  return capitalizedSentence;
}

// Converts hours/minutes into 2-digit
String _toTwoDigit(int value) {
  String twoDigit = value < 10 ? '0$value' : value.toString();
  return twoDigit;
}

// Converts DateTime value into a 2-digit AM/PM time
String _timeFromDateTime(String date) {
  DateTime temp = DateTime.parse(date);
  String minutes = _toTwoDigit(temp.minute);
  String hours = _toTwoDigit(temp.hour);
  int intHours = int.parse(hours);
  String time = intHours > 12 // Indicates time is AM/PM
      ? '${_toTwoDigit(intHours - 12)}:${minutes}PM' // applied PM with '-12 equation'
      : hours == '00'
          ? '12:${minutes}AM'
          : '$hours:${minutes}AM'; // Handles '00 hour at AM' edge case to be 12
  return time;
}
