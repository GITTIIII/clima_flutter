import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weather = WeatherModel();
  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    // Check if the location permission is already granted
    if (await Permission.location.isGranted) {
      // Proceed with your location-based functionality
      var data = await weather.getLocationWeather();
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(data: data),
        ),
      );
    } else {
      // Request location permission
      var status = await Permission.location.request();
      if (status.isGranted) {
        // If permission is granted, proceed with location functionality
        var data = await weather.getLocationWeather();
        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationScreen(data: data),
          ),
        );
      } else {
        if (!mounted) return;
        // Handle the case where permission is denied
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission is required.")),
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
