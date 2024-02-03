import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _currentWeather;
  final WeatherService _weatherService = WeatherService();

  Weather? get currentWeather => _currentWeather;

  Future<void> getWeather(String city) async {
    try {
      final weatherData = await _weatherService.getWeather(city);
      _currentWeather = weatherData;
      notifyListeners();
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }
}
