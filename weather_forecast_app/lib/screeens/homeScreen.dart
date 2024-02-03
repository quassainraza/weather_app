import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast_app/weather_provider.dart';

import '../widgets/forecastItem.dart';

class MyHomePage extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Image.asset(
                'assets/cloud.png', // Replace with your image asset
                height: 200.0,
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Enter City',
                  filled: true,
                  fillColor: Colors.white, // Background color of the text field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Border radius
                    borderSide:
                        const BorderSide(color: Colors.blue), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.blue), // Border color when focused
                  ),
                  prefixIcon: const Icon(Icons.location_city,
                      color: Colors.blue), // Icon on the left
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.blue),
                    onPressed: () {
                      _cityController.clear();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String city = _cityController.text;
                  if (city.isNotEmpty) {
                    Provider.of<WeatherProvider>(context, listen: false)
                        .getWeather(city);
                  }
                },
                child: const Text('Search'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32.0),
                  Consumer<WeatherProvider>(
                    builder: (context, weatherProvider, child) {
                      final weather = weatherProvider.currentWeather;
                      if (weather != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Card(
                                color: Colors.greenAccent,
                                elevation: 2.0,
                                margin: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('City: ${weather.city}'),
                                      const SizedBox(height: 8.0),
                                      Text(
                                          'Temperature: ${weather.temperature.toStringAsFixed(2)}°C'),
                                      const SizedBox(height: 8.0),
                                      Text(
                                          'Description: ${weather.description}'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            const Text('5-Day Forecast:'),
                            const SizedBox(height: 8.0),
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (var forecast in weather.forecast)
                                    ForecastItem(forecast: forecast),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text('No data available');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
