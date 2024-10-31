import 'package:clima_flutter/screens/city_screen.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import "../services/weather.dart";

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.data});

  final dynamic data;

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  double temp = 0;
  int tempInt = 0;
  String city = "";
  int condition = 0;

  void updateData(var data) {
    print(data);
    setState(() {
      temp = data['main']['temp'];
      tempInt = temp.toInt();
      city = data['name'].toString();
      condition = data['weather'][0]['id'];
    });
  }

  void initState() {
    super.initState();
    updateData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    WeatherModel weather = WeatherModel();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var newData = await weather.getLocationWeather();
                      setState(() {
                        updateData(newData);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      print(cityName);
                      var newData = await weather.getCityWeather(cityName);
                      if (cityName != null) {
                        setState(() {
                          updateData(newData);
                        });
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$tempInt°C",
                    style: kTempTextStyle,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    weather.getWeatherIcon(condition),
                    style: kConditionTextStyle,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "${weather.getMessage(tempInt)} in $city!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
