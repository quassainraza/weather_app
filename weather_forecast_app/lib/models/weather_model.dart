class Weather {
  final String city;
  final double temperature;
  final String description;
  final List<Forecast> forecast;

  Weather(
      {required this.city,
      required this.temperature,
      required this.description, required this.forecast,
      });
}

class Forecast {
  final DateTime date;
  final double temperature;
  final String description;
  final String icon;

  Forecast({
    required this.date,
    required this.temperature,
    required this.description,
    required this.icon,
  });
}