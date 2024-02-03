import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import 'package:intl/intl.dart';

class ForecastItem extends StatelessWidget {
  final Forecast forecast;

  const ForecastItem({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(

        leading: Image.network(
            'https://openweathermap.org/img/w/${forecast.icon}.png'),
        title: Text('Date: ${formattedDate(forecast.date)}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Temperature: ${forecast.temperature.toStringAsFixed(2)}°C'),
            Text('Description: ${forecast.description}'),
          ],
        ),
      ),
    );
  }

  String formattedDate(DateTime date) {
    String daySuffix = getDaySuffix(date.day);
    return DateFormat('EEEE d MMM yyyy').format(date);
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
