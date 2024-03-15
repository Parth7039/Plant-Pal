import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medigard/ui_pages/homepage.dart';
import 'package:medigard/weather_model.dart';
import 'package:medigard/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  int selected_index = 0;

  final _weatherService = WeatherService('cbbd33b619ae0b6517b5b2b37688ea46');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch (e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition){
    if (mainCondition == null) return 'assets/animations/search.json';

    switch (mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/animations/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/animations/rainy.json';
      case 'thunderstorm':
        return 'assets/animations/thunder.json';
      case 'clear':
        return 'assets/animations/sunny.json';
      default:
        return 'assets/animations/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_weather?.cityName ?? "loading city.."),

              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

              Text('${_weather?.temperature.round() ?? "loading temperature.."} Celsius'),

              Text(_weather?.mainCondition ?? "")
            ],
          ),
        ),
      ),
    );
  }
}
