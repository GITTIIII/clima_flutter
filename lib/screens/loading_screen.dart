import 'package:flutter/material.dart';
import "../services/location.dart";
import "../services/networking.dart";
import "./location_screen.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = "e714412cf39ce79ce81969d638b49e31";

class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();

  Future<void> getLocation() async {
    await location.getCurrentLocation();
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey");
    NetworkHelper network = NetworkHelper(url);
    var data = await network.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(data: data);
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
