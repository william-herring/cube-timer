import 'package:cube_timer/screens/timer.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

var event = 1;

Map<int, String> indexFromEvent = {
  0 : "2x2",
  1: "3x3",
  2 : "4x4",
  3 : "5x5",
  4 : "6x6",
  5 : "7x7",
  6 : "Pyraminx",
  7 : "Skewb",
  8 : "Square-1",
  9 : "Clock",
  10 : "Megaminx",
};

var solves = [];

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cube Timer',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(19, 19, 19, 1.0),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0.0),
            ),
          ),
      ),
      home: TimerScreen(),
    );
  }
}
