import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global.dart';
import '../models/weather_model.dart';

class WeatherService {
  Future<Weather> getWeather(String city) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'),
    );
    final forecastResponse = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey'),
    );

    if (forecastResponse.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> forecastList =
          json.decode(forecastResponse.body)['list'];
      List<Forecast> forecastData = [];

      for (var forecast in forecastList) {
        forecastData.add(Forecast(
          date: DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000),
          temperature: (forecast['main']['temp'] - 273.15),
          description: forecast['weather'][0]['description'],
          icon: forecast['weather'][0]['icon'],
        ));
      }

      return Weather(
        city: data['name'],
        temperature: (data['main']['temp'] - 273.15),
        description: data['weather'][0]['description'],
        forecast: forecastData,
      );
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
