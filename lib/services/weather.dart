import "../services/location.dart";
import "../services/networking.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';

const openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Location location = Location();

  Future<dynamic> getCityWeather(String cityName) async {
    var url = Uri.parse(
        "$openWeatherMapURL?q=$cityName&appid=${dotenv.env['API_KEY']}&units=metric");
    NetworkHelper network = NetworkHelper(url);
    var data = await network.getData();
    return data;
  }

  Future<dynamic> getLocationWeather() async {
    await location.getCurrentLocation();
    var url = Uri.parse(
        "$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=${dotenv.env['API_KEY']}&units=metric");
    NetworkHelper network = NetworkHelper(url);
    var data = await network.getData();
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
