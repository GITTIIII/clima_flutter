import 'package:flutter/material.dart';
import "../services/location.dart";
import "../services/networking.dart";
import "./location_screen.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';

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
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    // Check if the location permission is already granted
    if (await Permission.location.isGranted) {
      // Proceed with your location-based functionality
      getLocation();
    } else {
      // Request location permission
      var status = await Permission.location.request();
      if (status.isGranted) {
        // If permission is granted, proceed with location functionality
        getLocation();
      } else {
        // Handle the case where permission is denied
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permission is required.")),
        );
      }
    }
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
