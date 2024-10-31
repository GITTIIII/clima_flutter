import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 35.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 75.0,
);

var kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: const Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: "Enter city name",
  hintStyle: const TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide.none,
  ),
);
