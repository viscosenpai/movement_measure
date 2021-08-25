import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movement_measure/screens/background_title_screen.dart';
import 'package:movement_measure/screens/start_measurement_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Stack(
        fit: StackFit.expand,
        children: const <Widget>[
          BackgroundTitleScreen(),
          StartMeasurementScreen(),
        ],
      ),
    );
  }
}
