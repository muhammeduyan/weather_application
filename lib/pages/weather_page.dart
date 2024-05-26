import 'package:flutter/material.dart';
import 'package:weather_application/services/weather_service.dart';
import 'package:weather_application/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('a3d09e7ad1e4d32e1dc6ae4d627e57fc');
  Weather? _weather;

  //fetch the weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get the weather for the city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations

  //init state
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[

            // city name
            Text(_weather?.cityName ?? "loading city...",),

            // temperature 
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}