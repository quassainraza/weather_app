import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast_app/screeens/splash.dart';
import 'package:weather_forecast_app/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather Forecast App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
